package com.example.shellencrypt;

import java.io.File;
import java.io.FilenameFilter;
import java.text.SimpleDateFormat;
import java.util.Date;

public class MyClass {
    public static void main(String[] args) {
        try {
            if (args.length != 1) {
                throw new Exception("Invalid argument.");
            }
            //源apk-待加固的apk
            File inApk = new File(args[0]);
            if (!inApk.exists()) {
                throw new Exception("Input file apk not exist.");
            }
            //目标apk-加固后的apk
//            File outApk = new File(args[1]);
            File tmpFolder = new File("ShellEncrypt/apkDecompile");
            if (tmpFolder.exists()) {
                FileManager.deleteDir(tmpFolder.getAbsolutePath());
            }
            System.out.println("start to decompile " + inApk.getAbsolutePath() + " to " + tmpFolder.getAbsolutePath());
            //反编译apk到tmpFolder
            brut.apktool.Main.main(new String[] {
                    "d",
                    "-o",
                    tmpFolder.getAbsolutePath(),
                    inApk.getAbsolutePath(),
                    "-s",
                    "-f"
            });
            System.out.println("decompile finished.");

            /**
             * 1.对classes.dex进行加密后保存到assets/encrypt中
             */
            File assets = new File(tmpFolder, "assets");
            if(!assets.exists()) {
                assets.mkdir();
            }

            File[] dexFiles = tmpFolder.listFiles(new FilenameFilter() {
                @Override
                public boolean accept(File dir, String name) {
                    if (name.endsWith(".dex")) {
                        return true;
                    }
                    return false;
                }
            });
            for(File dexfile:dexFiles) {
                File encDex = new File(assets, dexfile.getName() + "encrypt");
                System.out.println("start to encrypt [" + dexfile.getName() + "]...");
                FileManager.copyFile(dexfile.getAbsolutePath(), encDex.getAbsolutePath(),
                        MyClass.class.getDeclaredMethod("encrypt", byte[].class));
                FileManager.deleteFile(dexfile);
            }


            /**
             * 2.插入smali代码到smali中（smali代码为反编译后的壳dex）
             */
            String smaliResPath = "ShellEncrypt/Resource/smali";
            System.out.println("start to copy shell smali file from " + smaliResPath + " to " + tmpFolder.getAbsolutePath());
            FileManager.copyFolder(smaliResPath, tmpFolder.getAbsolutePath());
/*            File libRes = FileManager.getResource("lib");
            System.out.println("start to copy lib file from " + libRes.getAbsolutePath());
            FileManager.copyFile(libRes, new File(tmpFolder, "lib"));*/

            /**
             * 3.解析AndroidManifest.xml
             * 获得Application标签, 插入android:name="com.example.protectappnative.ProxyApplication"
             * 如果本来就有的，就把原来的android:name="......"的数据放入metadata中
             *     <meta-data android:name="APPLICATION_CLASS_NAME" android:value="Old_Application" />
             */
            File manifest = new File(tmpFolder, "AndroidManifest.xml");
            System.out.println("start to fix AndroidManifest.xml");
            ManifestXml.modify(manifest);

            /**
             * 4.回编译，重新打包
             */
            System.out.println("start to recompile...");
            String apkName = inApk.getAbsolutePath();
            SimpleDateFormat df = new SimpleDateFormat("yyyyMMddHHmmss");
            String date = df.format(new Date());
            String unsignedApkName = apkName.substring(0, apkName.indexOf(".apk")) + "-unsigned-" + date + ".apk";
            File unsignedApk = new File(unsignedApkName);
            brut.apktool.Main.main(new String[] {
                    "b",
                    "-o",
                    unsignedApk.getAbsolutePath(),
                    tmpFolder.getAbsolutePath()
            });
            System.out.println("recompile finished.");

            /**
             * 5.重新签名
             */


            String signedApkName = apkName.substring(0, apkName.indexOf(".apk")) + "-signed-" + date + ".apk";
            File signedApk = new File(signedApkName);
            System.out.println("生成新的签名apk[" + signedApk.getName() + "]...");
            SignatureUtil.signature(unsignedApk, signedApk);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public static byte[] encrypt(byte[] b) {
        AESUtil.init(getPassword());
        return AESUtil.encrypt(b);
    }

    private static String getPassword() {
        return "1122334455667788";
    }
}
