package com.example.shellencrypt;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.FileReader;
import java.io.IOException;
import java.lang.reflect.Method;

class FileManager {
    public static void copyFolder(String resource, String target) throws Exception {
        File resourceFile = new File(resource);
        if (!resourceFile.exists()) {
            throw new Exception("源目标路径：[" + resource + "] 不存在...");
        }
        File targetFile = new File(target);

        // 获取源文件夹下的文件夹或文件
        File[] resourceFiles = resourceFile.listFiles();
        for (File file : resourceFiles) {
            File targetPath = new File(targetFile.getAbsolutePath() + File.separator + resourceFile.getName());
            // 复制文件
            if (file.isFile()) {
                System.out.println("copy: " + file.getName());
                if (!targetPath.exists()) {
                    targetPath.mkdirs();
                }
                File targetFile1 = new File(targetPath.getAbsolutePath() + File.separator + file.getName());
                copyFile(file, targetFile1);
            }
            // 复制文件夹
            if (file.isDirectory()) {
                // 源文件夹
                String dir1 = file.getAbsolutePath();
                // 目的文件夹
                String dir2 = targetPath.getAbsolutePath();
                copyFolder(dir1, dir2);
            }
        }

    }

    public static void copyFile(File srcFile, File destFile) {
        try {
            byte[] content = getBytes(srcFile);
            FileOutputStream os = new FileOutputStream(destFile);
            os.write(content);
            os.flush();
            os.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public static void copyFile(String dexFilePath, String encDexPath, Method encMethod) {
        try {
            File dexFile = new File(dexFilePath);
            File encDex = new File(encDexPath);
            byte[] content = getBytes(dexFile);
            byte[] encryptedContent = (encMethod!=null) ? (byte[]) encMethod.invoke(null, content):content;
            FileOutputStream os = new FileOutputStream(encDex);
            os.write(encryptedContent);
            os.flush();
            os.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public static void deleteFile(File classdex) {
        if (classdex.exists()) {
            classdex.delete();
        }
    }

    public static byte[] getBytes(File dexFile) {
        try {
            FileInputStream fis = new FileInputStream(dexFile);
            int len = -1;
            int fileLength = (int)dexFile.length();
            byte[] content = new byte[fileLength];
            byte[] buffer = new byte[1024];
            int current = 0;
            while ((len = fis.read(buffer, 0, 1024)) != -1 ) {
                System.arraycopy(buffer, 0, content, current, len);
                current += len;
            }
            fis.close();
            return content;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    /**
     * 迭代删除文件夹
     * @param dirPath 文件夹路径
     */
    public static void deleteDir(String dirPath) {
        File file = new File(dirPath);
        if(file.isFile()) {
            file.delete();
        } else {
            File[] files = file.listFiles();
            if(files == null) {
                file.delete();
            } else {
                for (int i = 0; i < files.length; i++) {
                    deleteDir(files[i].getAbsolutePath());
                }
                file.delete();
            }
        }
    }
}
