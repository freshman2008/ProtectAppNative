package com.example.protectappnative;

import android.Manifest;
import android.app.Activity;
import android.app.Application;
import android.app.Instrumentation;
import android.content.Context;
import android.content.pm.ApplicationInfo;
import android.content.pm.PackageManager;
import android.os.Bundle;
import android.support.v4.app.ActivityCompat;
import android.util.ArrayMap;
import android.util.Log;
import android.widget.Toast;

import java.io.File;
import java.io.IOException;
import java.lang.ref.WeakReference;
import java.util.ArrayList;
import java.util.Iterator;

import dalvik.system.DexClassLoader;

public class ProxyApplication extends Application {
    //先定义
    private static final int REQUEST_EXTERNAL_STORAGE = 1;

    private static String[] PERMISSIONS_STORAGE = {
            "android.permission.READ_EXTERNAL_STORAGE",
            "android.permission.WRITE_EXTERNAL_STORAGE" };


    private static final String appkey = "APPLICATION_CLASS_NAME";//原始apk的Application(metadata)，如果为null，则没有被继承

    private String cachePath = null;
    private String odexPath = null;
    private String libPath = null;
    private String srcDex = null;

    @Override
    public void onCreate() {
        String appClassName = null;
        try {
            ApplicationInfo applicationInfo = this.getPackageManager().getApplicationInfo(
                    this.getPackageName(),
                    PackageManager.GET_META_DATA);
            Bundle metaData = applicationInfo.metaData;
            if (metaData!=null && metaData.containsKey(appkey)) {
                appClassName = metaData.getString(appkey);//存在原始Application,需要进行调用
            }
        } catch (PackageManager.NameNotFoundException e) {
            e.printStackTrace();
        }
        /**
         * 下面为强制重构Application，参考Android源码
         * /frameworks/base/core/java/android/app/ActivityThread.java
         * /frameworks/base/core/java/android/app/LoadedApk.java
         */

        //首先清除原始的app数据
        Object currentActivityThread = RefInvoke.invokeStaticMethod(
                "android.app.ActivityThread",
                "currentActivityThread",
                new Class[]{}, new Object[]{});

        //AppBindData mBoundApplication;
        Object mBoundApplication = RefInvoke.getFieldObject(
                "android.app.ActivityThread",
                currentActivityThread,
                "mBoundApplication");

        /**
         * AppBindData是android.app.ActivityThread中的静态内部类
         * static final class AppBindData {
         *     LoadedApk info;
         *     String processName;
         *     ApplicationInfo appInfo
         *     ......
         * }
         */
        //AppBindData -> LoadedApk info;
        Object loadedApkInfo = RefInvoke.getFieldObject(
                "android.app.ActivityThread$AppBindData",
                mBoundApplication,
                "info");
        //把LoadedApk中的mApplication变量置空(之后会重新将其赋值)
        //LoadedApk -> private Application mApplication;
        RefInvoke.setFieldObject(
                "android.app.LoadedApk",
                "mApplication",
                loadedApkInfo,
                null);

        //获取原来的Application
        //ActivityThread -> Application mInitialApplication;
        Object oldApplication = RefInvoke.getFieldObject(
                "android.app.ActivityThread",
                currentActivityThread,
                "mInitialApplication");

        //ActivityThread -> final ArrayList<Application> mAllApplications = new ArrayList<Application>();
        ArrayList<Application> mAllApplications = (ArrayList<Application>)RefInvoke.getFieldObject(
                "android.app.ActivityThread",
                currentActivityThread,
                "mAllApplications");
        //删除原来的Application(之后会将新创建的Application添加进来)
        mAllApplications.remove(oldApplication);

        //LoadedApk -> private ApplicationInfo mApplicationInfo;
        ApplicationInfo appInfoInLoadedApk = (ApplicationInfo)RefInvoke.getFieldObject(
                "android.app.LoadedApk",
                loadedApkInfo,
                "mApplicationInfo");
        //AppBindData -> ApplicationInfo appInfo
        ApplicationInfo appInfoInAppBindData = (ApplicationInfo)RefInvoke.getFieldObject(
                "android.app.ActivityThread$AppBindData",
                mBoundApplication,
                "appInfo");

        //改写app信息
        appInfoInLoadedApk.className = appClassName;
        appInfoInAppBindData.className = appClassName;

        /**
         * public Application makeApplication(boolean forceDefaultAppClass,
         *         Instrumentation instrumentation) {
         *     if (mApplication != null) {
         *         return mApplication;
         *     }
         *     ......
         *     app = mActivityThread.mInstrumentation.newApplication(
         *             cl, appClass, appContext);
         *     ......
         *     mActivityThread.mAllApplications.add(app);
         *     mApplication = app;
         *     ......
         * }
         */
        Application newApp = (Application)RefInvoke.invokeMethod(
                "android.app.LoadedApk",
                "makeApplication",
                loadedApkInfo,
                new Class[]{boolean.class, Instrumentation.class},
                new Object[]{false, null});

        RefInvoke.setFieldObject(
                "android.app.ActivityThread",
                "mInitialApplication",
                currentActivityThread,
                newApp);

        //把所有ContentProvider中的mContext设置为新创建的Application
        //ActivityThread -> final ArrayMap<ProviderKey, ProviderClientRecord> mProviderMap = new ArrayMap<ProviderKey, ProviderClientRecord>();
        ArrayMap mProviderMap = (ArrayMap)RefInvoke.getFieldObject(
                "android.app.ActivityThread",
                currentActivityThread, "mProviderMap");
        Iterator iterator = mProviderMap.values().iterator();
        while (iterator.hasNext()) {
            Object providerClientRecord = iterator.next();
            Object localProvider = RefInvoke.getFieldObject(
                    "android.app.ActivityThread$ProviderClientRecord",
                    providerClientRecord,
                    "mLocalProvider");
            RefInvoke.setFieldObject(
                    "android.content.ContentProvider",
                    "mContext",
                    localProvider,
                    newApp);
        }
        super.onCreate();
    }

    @Override
    protected void attachBaseContext(Context base) {
        super.attachBaseContext(base);
        //从Assets目录中释放出dex文件，并且加载到内存中
//        verifyStoragePermissions((Activity) this);
        try {
            File cache = this.getDir(".fshell", MODE_PRIVATE);
            odexPath = this.getDir(".fodex", MODE_PRIVATE).getAbsolutePath();
            cachePath = cache.getAbsolutePath();
            libPath = this.getApplicationInfo().nativeLibraryDir;
            srcDex = cachePath + "/decrypt.dex";
            File decFile = FileManager.releaseAssetsFile(this, "encrypt", srcDex, this.getClass().getDeclaredMethod("decMethod", byte[].class));
            if(!decFile.exists()) {
                decFile.createNewFile();
            }

            Object currentActivityThread = RefInvoke.invokeStaticMethod(
                    "android.app.ActivityThread",
                    "currentActivityThread",
                    new Class[]{}, new Object[]{});

            /**
             * 获取ActivityThread中mPackages
             * mPackages定义如下：
             *  final ArrayMap<String, WeakReference<LoadedApk>> mPackages = new ArrayMap<String, WeakReference<LoadedApk>>();
             */
            String packageName = this.getPackageName();
            ArrayMap mPackages = (ArrayMap) RefInvoke.getFieldObject(
                    "android.app.ActivityThread",
                    currentActivityThread,
                    "mPackages");
            WeakReference wr = (WeakReference) mPackages.get(packageName);

            //加载dex文件，并替换掉原始ClassLoader
            /**
             * 获取LoadedApk中mClassLoader
             * mClassLoader定义如下：
             *  private ClassLoader mClassLoader;
             */
            DexClassLoader dexClassLoader = new DexClassLoader(srcDex, odexPath, libPath,
                    (ClassLoader) RefInvoke.getFieldObject("android.app.LoadedApk", wr.get(), "mClassLoader"));

            RefInvoke.setFieldObject("android.app.LoadedApk", "mClassLoader", wr.get(), dexClassLoader);
        } catch (NoSuchMethodException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    public static byte[] decMethod(byte[] enc) {
        Log.d("hello", "decrypt dex file.");
        AESUtil.init(getPassword());
        return AESUtil.decrypt(enc);
    }

    private static String getPassword() {
        return "1122334455667788";
    }

    //然后通过一个函数来申请
    public static void verifyStoragePermissions(Activity activity) {
        try {
            //检测是否有写的权限
            int permission = ActivityCompat.checkSelfPermission(activity,
                    "android.permission.WRITE_EXTERNAL_STORAGE");
            if (permission != PackageManager.PERMISSION_GRANTED) {
                // 没有写的权限，去申请写的权限，会弹出对话框
                ActivityCompat.requestPermissions(activity, PERMISSIONS_STORAGE, REQUEST_EXTERNAL_STORAGE);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

//    private void checkPermission(Context context) {
//        //检查权限（NEED_PERMISSION）是否被授权 PackageManager.PERMISSION_GRANTED表示同意授权
//        if (ActivityCompat.checkSelfPermission(this, Manifest.permission.WRITE_EXTERNAL_STORAGE)
//                != PackageManager.PERMISSION_GRANTED) {
//            //用户已经拒绝过一次，再次弹出权限申请对话框需要给用户一个解释
//            if (ActivityCompat.shouldShowRequestPermissionRationale(this, Manifest.permission
//                    .WRITE_EXTERNAL_STORAGE)) {
//                Toast.makeText(this, "请开通相关权限，否则无法正常使用本应用！", Toast.LENGTH_SHORT).show();
//            }
//            //申请权限
//            ActivityCompat.requestPermissions((Activity) context, new String[]{Manifest.permission.WRITE_EXTERNAL_STORAGE}, REQUEST_EXTERNAL_STORAGE);
//
//        } else {
//            Toast.makeText(this, "授权成功！", Toast.LENGTH_SHORT).show();
//            Log.e("hello", "checkPermission: 已经授权！");
//        }
//    }
}
