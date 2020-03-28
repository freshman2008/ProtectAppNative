package com.example.protectappnative;

import android.content.Context;
import android.content.res.AssetManager;

import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;

public class FileManager {
    /**
     * 解密加密的文件
     * @param ctx Context
     * @param assetFile 资源名称
     * @param releaseFile 释放到目录下
     * @param decMethod 解密资源的方法，public static byte[] dec(byte[] src);
     * @return
     */
    public static File releaseAssetsFile(Context ctx, String assetFile, String releaseFile, Method decMethod) {
        AssetManager manager = ctx.getAssets();
        try {
            InputStream is = manager.open(assetFile);
            ByteArrayOutputStream os = new ByteArrayOutputStream();
            int len;
            byte[] buff = new byte[1024];
            while ((len=is.read(buff)) != -1) {
                os.write(buff, 0, len);
            }

            byte[] dec= (decMethod!=null) ? (byte[]) decMethod.invoke(null, os.toByteArray()):os.toByteArray();
            is.close();
            os.close();

            File outFile = new File(releaseFile);
            FileOutputStream fos = new FileOutputStream(outFile);
            fos.write(dec);
            fos.flush();
            fos.close();
            return outFile;
        } catch (IOException e) {
            e.printStackTrace();
        } catch (IllegalAccessException e) {
            e.printStackTrace();
        } catch (InvocationTargetException e) {
            e.printStackTrace();
        }
        return null;
    }
}
