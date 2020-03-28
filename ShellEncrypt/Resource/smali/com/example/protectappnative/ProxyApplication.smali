.class public Lcom/example/protectappnative/ProxyApplication;
.super Landroid/app/Application;
.source "ProxyApplication.java"


# static fields
.field private static PERMISSIONS_STORAGE:[Ljava/lang/String; = null

.field private static final REQUEST_EXTERNAL_STORAGE:I = 0x1

.field private static final appkey:Ljava/lang/String; = "APPLICATION_CLASS_NAME"


# instance fields
.field private cachePath:Ljava/lang/String;

.field private libPath:Ljava/lang/String;

.field private odexPath:Ljava/lang/String;

.field private srcDex:Ljava/lang/String;


# direct methods
.method static constructor <clinit>()V
    .locals 2

    .line 28
    const-string v0, "android.permission.READ_EXTERNAL_STORAGE"

    const-string v1, "android.permission.WRITE_EXTERNAL_STORAGE"

    filled-new-array {v0, v1}, [Ljava/lang/String;

    move-result-object v0

    sput-object v0, Lcom/example/protectappnative/ProxyApplication;->PERMISSIONS_STORAGE:[Ljava/lang/String;

    return-void
.end method

.method public constructor <init>()V
    .locals 1

    .line 24
    invoke-direct {p0}, Landroid/app/Application;-><init>()V

    .line 35
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/example/protectappnative/ProxyApplication;->cachePath:Ljava/lang/String;

    .line 36
    iput-object v0, p0, Lcom/example/protectappnative/ProxyApplication;->odexPath:Ljava/lang/String;

    .line 37
    iput-object v0, p0, Lcom/example/protectappnative/ProxyApplication;->libPath:Ljava/lang/String;

    .line 38
    iput-object v0, p0, Lcom/example/protectappnative/ProxyApplication;->srcDex:Ljava/lang/String;

    return-void
.end method

.method public static decMethod([B)[B
    .locals 2
    .param p0, "enc"    # [B

    .line 224
    const-string v0, "hello"

    const-string v1, "decrypt dex file."

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 225
    invoke-static {}, Lcom/example/protectappnative/ProxyApplication;->getPassword()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/example/protectappnative/AESUtil;->init(Ljava/lang/String;)V

    .line 226
    invoke-static {p0}, Lcom/example/protectappnative/AESUtil;->decrypt([B)[B

    move-result-object v0

    return-object v0
.end method

.method private static getPassword()Ljava/lang/String;
    .locals 1

    .line 230
    const-string v0, "1122334455667788"

    return-object v0
.end method

.method public static verifyStoragePermissions(Landroid/app/Activity;)V
    .locals 3
    .param p0, "activity"    # Landroid/app/Activity;

    .line 237
    :try_start_0
    const-string v0, "android.permission.WRITE_EXTERNAL_STORAGE"

    invoke-static {p0, v0}, Landroid/support/v4/app/ActivityCompat;->checkSelfPermission(Landroid/content/Context;Ljava/lang/String;)I

    move-result v0

    .line 239
    .local v0, "permission":I
    if-eqz v0, :cond_0

    .line 241
    sget-object v1, Lcom/example/protectappnative/ProxyApplication;->PERMISSIONS_STORAGE:[Ljava/lang/String;

    const/4 v2, 0x1

    invoke-static {p0, v1, v2}, Landroid/support/v4/app/ActivityCompat;->requestPermissions(Landroid/app/Activity;[Ljava/lang/String;I)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 245
    .end local v0    # "permission":I
    :cond_0
    goto :goto_0

    .line 243
    :catch_0
    move-exception v0

    .line 244
    .local v0, "e":Ljava/lang/Exception;
    invoke-virtual {v0}, Ljava/lang/Exception;->printStackTrace()V

    .line 246
    .end local v0    # "e":Ljava/lang/Exception;
    :goto_0
    return-void
.end method


# virtual methods
.method protected attachBaseContext(Landroid/content/Context;)V
    .locals 13
    .param p1, "base"    # Landroid/content/Context;

    .line 175
    const-string v0, "mClassLoader"

    const-string v1, "android.app.LoadedApk"

    const-string v2, "android.app.ActivityThread"

    invoke-super {p0, p1}, Landroid/app/Application;->attachBaseContext(Landroid/content/Context;)V

    .line 179
    :try_start_0
    const-string v3, ".fshell"

    const/4 v4, 0x0

    invoke-virtual {p0, v3, v4}, Lcom/example/protectappnative/ProxyApplication;->getDir(Ljava/lang/String;I)Ljava/io/File;

    move-result-object v3

    .line 180
    .local v3, "cache":Ljava/io/File;
    const-string v5, ".fodex"

    invoke-virtual {p0, v5, v4}, Lcom/example/protectappnative/ProxyApplication;->getDir(Ljava/lang/String;I)Ljava/io/File;

    move-result-object v5

    invoke-virtual {v5}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v5

    iput-object v5, p0, Lcom/example/protectappnative/ProxyApplication;->odexPath:Ljava/lang/String;

    .line 181
    invoke-virtual {v3}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v5

    iput-object v5, p0, Lcom/example/protectappnative/ProxyApplication;->cachePath:Ljava/lang/String;

    .line 182
    invoke-virtual {p0}, Lcom/example/protectappnative/ProxyApplication;->getApplicationInfo()Landroid/content/pm/ApplicationInfo;

    move-result-object v5

    iget-object v5, v5, Landroid/content/pm/ApplicationInfo;->nativeLibraryDir:Ljava/lang/String;

    iput-object v5, p0, Lcom/example/protectappnative/ProxyApplication;->libPath:Ljava/lang/String;

    .line 183
    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    iget-object v6, p0, Lcom/example/protectappnative/ProxyApplication;->cachePath:Ljava/lang/String;

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v6, "/decrypt.dex"

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    iput-object v5, p0, Lcom/example/protectappnative/ProxyApplication;->srcDex:Ljava/lang/String;

    .line 184
    const-string v6, "encrypt"

    invoke-virtual {p0}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v7

    const-string v8, "decMethod"

    const/4 v9, 0x1

    new-array v9, v9, [Ljava/lang/Class;

    const-class v10, [B

    aput-object v10, v9, v4

    invoke-virtual {v7, v8, v9}, Ljava/lang/Class;->getDeclaredMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v7

    invoke-static {p0, v6, v5, v7}, Lcom/example/protectappnative/FileManager;->releaseAssetsFile(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;Ljava/lang/reflect/Method;)Ljava/io/File;

    move-result-object v5

    .line 185
    .local v5, "decFile":Ljava/io/File;
    invoke-virtual {v5}, Ljava/io/File;->exists()Z

    move-result v6

    if-nez v6, :cond_0

    .line 186
    invoke-virtual {v5}, Ljava/io/File;->createNewFile()Z

    .line 189
    :cond_0
    const-string v6, "currentActivityThread"

    new-array v7, v4, [Ljava/lang/Class;

    new-array v4, v4, [Ljava/lang/Object;

    invoke-static {v2, v6, v7, v4}, Lcom/example/protectappnative/RefInvoke;->invokeStaticMethod(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Class;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v4

    .line 199
    .local v4, "currentActivityThread":Ljava/lang/Object;
    invoke-virtual {p0}, Lcom/example/protectappnative/ProxyApplication;->getPackageName()Ljava/lang/String;

    move-result-object v6

    .line 200
    .local v6, "packageName":Ljava/lang/String;
    const-string v7, "mPackages"

    invoke-static {v2, v4, v7}, Lcom/example/protectappnative/RefInvoke;->getFieldObject(Ljava/lang/String;Ljava/lang/Object;Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Landroid/util/ArrayMap;

    .line 204
    .local v2, "mPackages":Landroid/util/ArrayMap;
    invoke-virtual {v2, v6}, Landroid/util/ArrayMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v7

    check-cast v7, Ljava/lang/ref/WeakReference;

    .line 212
    .local v7, "wr":Ljava/lang/ref/WeakReference;
    new-instance v8, Ldalvik/system/DexClassLoader;

    iget-object v9, p0, Lcom/example/protectappnative/ProxyApplication;->srcDex:Ljava/lang/String;

    iget-object v10, p0, Lcom/example/protectappnative/ProxyApplication;->odexPath:Ljava/lang/String;

    iget-object v11, p0, Lcom/example/protectappnative/ProxyApplication;->libPath:Ljava/lang/String;

    .line 213
    invoke-virtual {v7}, Ljava/lang/ref/WeakReference;->get()Ljava/lang/Object;

    move-result-object v12

    invoke-static {v1, v12, v0}, Lcom/example/protectappnative/RefInvoke;->getFieldObject(Ljava/lang/String;Ljava/lang/Object;Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v12

    check-cast v12, Ljava/lang/ClassLoader;

    invoke-direct {v8, v9, v10, v11, v12}, Ldalvik/system/DexClassLoader;-><init>(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/ClassLoader;)V

    .line 215
    .local v8, "dexClassLoader":Ldalvik/system/DexClassLoader;
    invoke-virtual {v7}, Ljava/lang/ref/WeakReference;->get()Ljava/lang/Object;

    move-result-object v9

    invoke-static {v1, v0, v9, v8}, Lcom/example/protectappnative/RefInvoke;->setFieldObject(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Object;Ljava/lang/Object;)V
    :try_end_0
    .catch Ljava/lang/NoSuchMethodException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    .end local v2    # "mPackages":Landroid/util/ArrayMap;
    .end local v3    # "cache":Ljava/io/File;
    .end local v4    # "currentActivityThread":Ljava/lang/Object;
    .end local v5    # "decFile":Ljava/io/File;
    .end local v6    # "packageName":Ljava/lang/String;
    .end local v7    # "wr":Ljava/lang/ref/WeakReference;
    .end local v8    # "dexClassLoader":Ldalvik/system/DexClassLoader;
    goto :goto_0

    .line 218
    :catch_0
    move-exception v0

    .line 219
    .local v0, "e":Ljava/io/IOException;
    invoke-virtual {v0}, Ljava/io/IOException;->printStackTrace()V

    goto :goto_1

    .line 216
    .end local v0    # "e":Ljava/io/IOException;
    :catch_1
    move-exception v0

    .line 217
    .local v0, "e":Ljava/lang/NoSuchMethodException;
    invoke-virtual {v0}, Ljava/lang/NoSuchMethodException;->printStackTrace()V

    .line 220
    .end local v0    # "e":Ljava/lang/NoSuchMethodException;
    :goto_0
    nop

    .line 221
    :goto_1
    return-void
.end method

.method public onCreate()V
    .locals 17

    .line 42
    const-string v0, "APPLICATION_CLASS_NAME"

    const/4 v1, 0x0

    .line 44
    .local v1, "appClassName":Ljava/lang/String;
    :try_start_0
    invoke-virtual/range {p0 .. p0}, Lcom/example/protectappnative/ProxyApplication;->getPackageManager()Landroid/content/pm/PackageManager;

    move-result-object v2

    .line 45
    invoke-virtual/range {p0 .. p0}, Lcom/example/protectappnative/ProxyApplication;->getPackageName()Ljava/lang/String;

    move-result-object v3

    const/16 v4, 0x80

    .line 44
    invoke-virtual {v2, v3, v4}, Landroid/content/pm/PackageManager;->getApplicationInfo(Ljava/lang/String;I)Landroid/content/pm/ApplicationInfo;

    move-result-object v2

    .line 47
    .local v2, "applicationInfo":Landroid/content/pm/ApplicationInfo;
    iget-object v3, v2, Landroid/content/pm/ApplicationInfo;->metaData:Landroid/os/Bundle;

    .line 48
    .local v3, "metaData":Landroid/os/Bundle;
    if-eqz v3, :cond_0

    invoke-virtual {v3, v0}, Landroid/os/Bundle;->containsKey(Ljava/lang/String;)Z

    move-result v4

    if-eqz v4, :cond_0

    .line 49
    invoke-virtual {v3, v0}, Landroid/os/Bundle;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0
    :try_end_0
    .catch Landroid/content/pm/PackageManager$NameNotFoundException; {:try_start_0 .. :try_end_0} :catch_0

    move-object v1, v0

    .line 53
    .end local v2    # "applicationInfo":Landroid/content/pm/ApplicationInfo;
    .end local v3    # "metaData":Landroid/os/Bundle;
    :cond_0
    goto :goto_0

    .line 51
    :catch_0
    move-exception v0

    .line 52
    .local v0, "e":Landroid/content/pm/PackageManager$NameNotFoundException;
    invoke-virtual {v0}, Landroid/content/pm/PackageManager$NameNotFoundException;->printStackTrace()V

    .line 61
    .end local v0    # "e":Landroid/content/pm/PackageManager$NameNotFoundException;
    :goto_0
    const/4 v0, 0x0

    new-array v2, v0, [Ljava/lang/Class;

    new-array v3, v0, [Ljava/lang/Object;

    const-string v4, "android.app.ActivityThread"

    const-string v5, "currentActivityThread"

    invoke-static {v4, v5, v2, v3}, Lcom/example/protectappnative/RefInvoke;->invokeStaticMethod(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Class;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v2

    .line 67
    .local v2, "currentActivityThread":Ljava/lang/Object;
    const-string v3, "mBoundApplication"

    invoke-static {v4, v2, v3}, Lcom/example/protectappnative/RefInvoke;->getFieldObject(Ljava/lang/String;Ljava/lang/Object;Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v3

    .line 82
    .local v3, "mBoundApplication":Ljava/lang/Object;
    const-string v5, "android.app.ActivityThread$AppBindData"

    const-string v6, "info"

    invoke-static {v5, v3, v6}, Lcom/example/protectappnative/RefInvoke;->getFieldObject(Ljava/lang/String;Ljava/lang/Object;Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v6

    .line 88
    .local v6, "loadedApkInfo":Ljava/lang/Object;
    const/4 v7, 0x0

    const-string v8, "android.app.LoadedApk"

    const-string v9, "mApplication"

    invoke-static {v8, v9, v6, v7}, Lcom/example/protectappnative/RefInvoke;->setFieldObject(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Object;Ljava/lang/Object;)V

    .line 96
    const-string v9, "mInitialApplication"

    invoke-static {v4, v2, v9}, Lcom/example/protectappnative/RefInvoke;->getFieldObject(Ljava/lang/String;Ljava/lang/Object;Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v10

    .line 102
    .local v10, "oldApplication":Ljava/lang/Object;
    const-string v11, "mAllApplications"

    invoke-static {v4, v2, v11}, Lcom/example/protectappnative/RefInvoke;->getFieldObject(Ljava/lang/String;Ljava/lang/Object;Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v11

    check-cast v11, Ljava/util/ArrayList;

    .line 107
    .local v11, "mAllApplications":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Landroid/app/Application;>;"
    invoke-virtual {v11, v10}, Ljava/util/ArrayList;->remove(Ljava/lang/Object;)Z

    .line 110
    const-string v12, "mApplicationInfo"

    invoke-static {v8, v6, v12}, Lcom/example/protectappnative/RefInvoke;->getFieldObject(Ljava/lang/String;Ljava/lang/Object;Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v12

    check-cast v12, Landroid/content/pm/ApplicationInfo;

    .line 115
    .local v12, "appInfoInLoadedApk":Landroid/content/pm/ApplicationInfo;
    const-string v13, "appInfo"

    invoke-static {v5, v3, v13}, Lcom/example/protectappnative/RefInvoke;->getFieldObject(Ljava/lang/String;Ljava/lang/Object;Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v5

    check-cast v5, Landroid/content/pm/ApplicationInfo;

    .line 121
    .local v5, "appInfoInAppBindData":Landroid/content/pm/ApplicationInfo;
    iput-object v1, v12, Landroid/content/pm/ApplicationInfo;->className:Ljava/lang/String;

    .line 122
    iput-object v1, v5, Landroid/content/pm/ApplicationInfo;->className:Ljava/lang/String;

    .line 139
    const/4 v13, 0x2

    new-array v14, v13, [Ljava/lang/Class;

    sget-object v15, Ljava/lang/Boolean;->TYPE:Ljava/lang/Class;

    aput-object v15, v14, v0

    const-class v15, Landroid/app/Instrumentation;

    const/16 v16, 0x1

    aput-object v15, v14, v16

    new-array v13, v13, [Ljava/lang/Object;

    .line 144
    invoke-static {v0}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v15

    aput-object v15, v13, v0

    aput-object v7, v13, v16

    .line 139
    const-string v0, "makeApplication"

    invoke-static {v8, v0, v6, v14, v13}, Lcom/example/protectappnative/RefInvoke;->invokeMethod(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Object;[Ljava/lang/Class;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/app/Application;

    .line 146
    .local v0, "newApp":Landroid/app/Application;
    invoke-static {v4, v9, v2, v0}, Lcom/example/protectappnative/RefInvoke;->setFieldObject(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Object;Ljava/lang/Object;)V

    .line 154
    const-string v7, "mProviderMap"

    invoke-static {v4, v2, v7}, Lcom/example/protectappnative/RefInvoke;->getFieldObject(Ljava/lang/String;Ljava/lang/Object;Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Landroid/util/ArrayMap;

    .line 157
    .local v4, "mProviderMap":Landroid/util/ArrayMap;
    invoke-virtual {v4}, Landroid/util/ArrayMap;->values()Ljava/util/Collection;

    move-result-object v7

    invoke-interface {v7}, Ljava/util/Collection;->iterator()Ljava/util/Iterator;

    move-result-object v7

    .line 158
    .local v7, "iterator":Ljava/util/Iterator;
    :goto_1
    invoke-interface {v7}, Ljava/util/Iterator;->hasNext()Z

    move-result v8

    if-eqz v8, :cond_1

    .line 159
    invoke-interface {v7}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v8

    .line 160
    .local v8, "providerClientRecord":Ljava/lang/Object;
    const-string v9, "android.app.ActivityThread$ProviderClientRecord"

    const-string v13, "mLocalProvider"

    invoke-static {v9, v8, v13}, Lcom/example/protectappnative/RefInvoke;->getFieldObject(Ljava/lang/String;Ljava/lang/Object;Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v9

    .line 164
    .local v9, "localProvider":Ljava/lang/Object;
    const-string v13, "android.content.ContentProvider"

    const-string v14, "mContext"

    invoke-static {v13, v14, v9, v0}, Lcom/example/protectappnative/RefInvoke;->setFieldObject(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Object;Ljava/lang/Object;)V

    .line 169
    .end local v8    # "providerClientRecord":Ljava/lang/Object;
    .end local v9    # "localProvider":Ljava/lang/Object;
    goto :goto_1

    .line 170
    :cond_1
    invoke-super/range {p0 .. p0}, Landroid/app/Application;->onCreate()V

    .line 171
    return-void
.end method
