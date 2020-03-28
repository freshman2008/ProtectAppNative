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

    .line 29
    const-string v0, "android.permission.READ_EXTERNAL_STORAGE"

    const-string v1, "android.permission.WRITE_EXTERNAL_STORAGE"

    filled-new-array {v0, v1}, [Ljava/lang/String;

    move-result-object v0

    sput-object v0, Lcom/example/protectappnative/ProxyApplication;->PERMISSIONS_STORAGE:[Ljava/lang/String;

    return-void
.end method

.method public constructor <init>()V
    .locals 1

    .line 25
    invoke-direct {p0}, Landroid/app/Application;-><init>()V

    .line 36
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/example/protectappnative/ProxyApplication;->cachePath:Ljava/lang/String;

    .line 37
    iput-object v0, p0, Lcom/example/protectappnative/ProxyApplication;->odexPath:Ljava/lang/String;

    .line 38
    iput-object v0, p0, Lcom/example/protectappnative/ProxyApplication;->libPath:Ljava/lang/String;

    .line 39
    iput-object v0, p0, Lcom/example/protectappnative/ProxyApplication;->srcDex:Ljava/lang/String;

    return-void
.end method

.method public static decMethod([B)[B
    .locals 2
    .param p0, "enc"    # [B

    .line 265
    const-string v0, "hello"

    const-string v1, "decrypt dex file."

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 266
    invoke-static {}, Lcom/example/protectappnative/ProxyApplication;->getPassword()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/example/protectappnative/AESUtil;->init(Ljava/lang/String;)V

    .line 267
    invoke-static {p0}, Lcom/example/protectappnative/AESUtil;->decrypt([B)[B

    move-result-object v0

    return-object v0
.end method

.method private static getPassword()Ljava/lang/String;
    .locals 1

    .line 271
    const-string v0, "1122334455667788"

    return-object v0
.end method

.method public static verifyStoragePermissions(Landroid/app/Activity;)V
    .locals 3
    .param p0, "activity"    # Landroid/app/Activity;

    .line 278
    :try_start_0
    const-string v0, "android.permission.WRITE_EXTERNAL_STORAGE"

    invoke-static {p0, v0}, Landroid/support/v4/app/ActivityCompat;->checkSelfPermission(Landroid/content/Context;Ljava/lang/String;)I

    move-result v0

    .line 280
    .local v0, "permission":I
    if-eqz v0, :cond_0

    .line 282
    sget-object v1, Lcom/example/protectappnative/ProxyApplication;->PERMISSIONS_STORAGE:[Ljava/lang/String;

    const/4 v2, 0x1

    invoke-static {p0, v1, v2}, Landroid/support/v4/app/ActivityCompat;->requestPermissions(Landroid/app/Activity;[Ljava/lang/String;I)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 286
    .end local v0    # "permission":I
    :cond_0
    goto :goto_0

    .line 284
    :catch_0
    move-exception v0

    .line 285
    .local v0, "e":Ljava/lang/Exception;
    invoke-virtual {v0}, Ljava/lang/Exception;->printStackTrace()V

    .line 287
    .end local v0    # "e":Ljava/lang/Exception;
    :goto_0
    return-void
.end method


# virtual methods
.method protected attachBaseContext(Landroid/content/Context;)V
    .locals 16
    .param p1, "base"    # Landroid/content/Context;

    .line 186
    move-object/from16 v1, p0

    const-string v0, "mClassLoader"

    const-string v2, "android.app.LoadedApk"

    const-string v3, "android.app.ActivityThread"

    const-string v4, ""

    invoke-super/range {p0 .. p1}, Landroid/app/Application;->attachBaseContext(Landroid/content/Context;)V

    .line 190
    :try_start_0
    const-string v5, ".fshell"

    const/4 v6, 0x0

    invoke-virtual {v1, v5, v6}, Lcom/example/protectappnative/ProxyApplication;->getDir(Ljava/lang/String;I)Ljava/io/File;

    move-result-object v5

    .line 191
    .local v5, "cache":Ljava/io/File;
    const-string v7, ".fodex"

    invoke-virtual {v1, v7, v6}, Lcom/example/protectappnative/ProxyApplication;->getDir(Ljava/lang/String;I)Ljava/io/File;

    move-result-object v7

    invoke-virtual {v7}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v7

    iput-object v7, v1, Lcom/example/protectappnative/ProxyApplication;->odexPath:Ljava/lang/String;

    .line 192
    invoke-virtual {v5}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v7

    iput-object v7, v1, Lcom/example/protectappnative/ProxyApplication;->cachePath:Ljava/lang/String;

    .line 193
    invoke-virtual/range {p0 .. p0}, Lcom/example/protectappnative/ProxyApplication;->getApplicationInfo()Landroid/content/pm/ApplicationInfo;

    move-result-object v7

    iget-object v7, v7, Landroid/content/pm/ApplicationInfo;->nativeLibraryDir:Ljava/lang/String;

    iput-object v7, v1, Lcom/example/protectappnative/ProxyApplication;->libPath:Ljava/lang/String;

    .line 196
    invoke-virtual/range {p1 .. p1}, Landroid/content/Context;->getAssets()Landroid/content/res/AssetManager;

    move-result-object v7

    invoke-virtual {v7, v4}, Landroid/content/res/AssetManager;->list(Ljava/lang/String;)[Ljava/lang/String;

    move-result-object v7

    .line 197
    .local v7, "fileNames":[Ljava/lang/String;
    array-length v8, v7

    const/4 v9, 0x0

    :goto_0
    const/4 v10, 0x1

    if-ge v9, v8, :cond_1

    aget-object v11, v7, v9

    .line 198
    .local v11, "filename":Ljava/lang/String;
    const-string v12, ".dexencrypt"

    invoke-virtual {v11, v12}, Ljava/lang/String;->endsWith(Ljava/lang/String;)Z

    move-result v12

    if-eqz v12, :cond_0

    .line 199
    new-instance v12, Ljava/lang/StringBuilder;

    invoke-direct {v12}, Ljava/lang/StringBuilder;-><init>()V

    iget-object v13, v1, Lcom/example/protectappnative/ProxyApplication;->cachePath:Ljava/lang/String;

    invoke-virtual {v12, v13}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v13, "/"

    invoke-virtual {v12, v13}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v13, "encrypt"

    invoke-virtual {v11, v13}, Ljava/lang/String;->lastIndexOf(Ljava/lang/String;)I

    move-result v13

    invoke-virtual {v11, v6, v13}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v13

    invoke-virtual {v12, v13}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v12}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v12

    .line 200
    .local v12, "decFileName":Ljava/lang/String;
    invoke-virtual/range {p0 .. p0}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v13

    const-string v14, "decMethod"

    new-array v10, v10, [Ljava/lang/Class;

    const-class v15, [B

    aput-object v15, v10, v6

    invoke-virtual {v13, v14, v10}, Ljava/lang/Class;->getDeclaredMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v10

    invoke-static {v1, v11, v12, v10}, Lcom/example/protectappnative/FileManager;->releaseAssetsFile(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;Ljava/lang/reflect/Method;)Ljava/io/File;

    move-result-object v10

    .line 201
    .local v10, "decFile":Ljava/io/File;
    invoke-virtual {v10}, Ljava/io/File;->exists()Z

    move-result v13

    if-nez v13, :cond_0

    .line 202
    invoke-virtual {v10}, Ljava/io/File;->createNewFile()Z

    .line 197
    .end local v10    # "decFile":Ljava/io/File;
    .end local v11    # "filename":Ljava/lang/String;
    .end local v12    # "decFileName":Ljava/lang/String;
    :cond_0
    add-int/lit8 v9, v9, 0x1

    goto :goto_0

    .line 207
    :cond_1
    const-string v8, "currentActivityThread"

    new-array v9, v6, [Ljava/lang/Class;

    new-array v6, v6, [Ljava/lang/Object;

    invoke-static {v3, v8, v9, v6}, Lcom/example/protectappnative/RefInvoke;->invokeStaticMethod(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Class;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v6

    .line 217
    .local v6, "currentActivityThread":Ljava/lang/Object;
    invoke-virtual/range {p0 .. p0}, Lcom/example/protectappnative/ProxyApplication;->getPackageName()Ljava/lang/String;

    move-result-object v8

    .line 218
    .local v8, "packageName":Ljava/lang/String;
    const-string v9, "mPackages"

    invoke-static {v3, v6, v9}, Lcom/example/protectappnative/RefInvoke;->getFieldObject(Ljava/lang/String;Ljava/lang/Object;Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Landroid/util/ArrayMap;

    .line 222
    .local v3, "mPackages":Landroid/util/ArrayMap;
    invoke-virtual {v3, v8}, Landroid/util/ArrayMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v9

    check-cast v9, Ljava/lang/ref/WeakReference;

    .line 235
    .local v9, "wr":Ljava/lang/ref/WeakReference;
    new-instance v11, Ljava/io/File;

    iget-object v12, v1, Lcom/example/protectappnative/ProxyApplication;->cachePath:Ljava/lang/String;

    invoke-direct {v11, v12}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    .line 236
    .local v11, "filePath":Ljava/io/File;
    new-instance v12, Lcom/example/protectappnative/ProxyApplication$1;

    invoke-direct {v12, v1}, Lcom/example/protectappnative/ProxyApplication$1;-><init>(Lcom/example/protectappnative/ProxyApplication;)V

    invoke-virtual {v11, v12}, Ljava/io/File;->listFiles(Ljava/io/FilenameFilter;)[Ljava/io/File;

    move-result-object v12

    .line 245
    .local v12, "dexFiles":[Ljava/io/File;
    nop

    .line 246
    .local v4, "dexPath":Ljava/lang/String;
    const/4 v13, 0x0

    .local v13, "i":I
    :goto_1
    array-length v14, v12

    if-ge v13, v14, :cond_3

    .line 247
    new-instance v14, Ljava/lang/StringBuilder;

    invoke-direct {v14}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v14, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    aget-object v15, v12, v13

    invoke-virtual {v15}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v15

    invoke-virtual {v14, v15}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v14}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v14

    move-object v4, v14

    .line 248
    array-length v14, v12

    sub-int/2addr v14, v10

    if-ge v13, v14, :cond_2

    .line 249
    new-instance v14, Ljava/lang/StringBuilder;

    invoke-direct {v14}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v14, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v15, ":"

    invoke-virtual {v14, v15}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v14}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v14

    move-object v4, v14

    .line 246
    :cond_2
    add-int/lit8 v13, v13, 0x1

    goto :goto_1

    .line 252
    .end local v13    # "i":I
    :cond_3
    const-string v10, "hello"

    new-instance v13, Ljava/lang/StringBuilder;

    invoke-direct {v13}, Ljava/lang/StringBuilder;-><init>()V

    const-string v14, "dexPath:"

    invoke-virtual {v13, v14}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v13, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v13}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v13

    invoke-static {v10, v13}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 253
    new-instance v10, Ldalvik/system/DexClassLoader;

    iget-object v13, v1, Lcom/example/protectappnative/ProxyApplication;->odexPath:Ljava/lang/String;

    iget-object v14, v1, Lcom/example/protectappnative/ProxyApplication;->libPath:Ljava/lang/String;

    .line 254
    invoke-virtual {v9}, Ljava/lang/ref/WeakReference;->get()Ljava/lang/Object;

    move-result-object v15

    invoke-static {v2, v15, v0}, Lcom/example/protectappnative/RefInvoke;->getFieldObject(Ljava/lang/String;Ljava/lang/Object;Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v15

    check-cast v15, Ljava/lang/ClassLoader;

    invoke-direct {v10, v4, v13, v14, v15}, Ldalvik/system/DexClassLoader;-><init>(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/ClassLoader;)V

    .line 256
    .local v10, "dexClassLoader":Ldalvik/system/DexClassLoader;
    invoke-virtual {v9}, Ljava/lang/ref/WeakReference;->get()Ljava/lang/Object;

    move-result-object v13

    invoke-static {v2, v0, v13, v10}, Lcom/example/protectappnative/RefInvoke;->setFieldObject(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Object;Ljava/lang/Object;)V
    :try_end_0
    .catch Ljava/lang/NoSuchMethodException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    .end local v3    # "mPackages":Landroid/util/ArrayMap;
    .end local v4    # "dexPath":Ljava/lang/String;
    .end local v5    # "cache":Ljava/io/File;
    .end local v6    # "currentActivityThread":Ljava/lang/Object;
    .end local v7    # "fileNames":[Ljava/lang/String;
    .end local v8    # "packageName":Ljava/lang/String;
    .end local v9    # "wr":Ljava/lang/ref/WeakReference;
    .end local v10    # "dexClassLoader":Ldalvik/system/DexClassLoader;
    .end local v11    # "filePath":Ljava/io/File;
    .end local v12    # "dexFiles":[Ljava/io/File;
    goto :goto_2

    .line 259
    :catch_0
    move-exception v0

    .line 260
    .local v0, "e":Ljava/io/IOException;
    invoke-virtual {v0}, Ljava/io/IOException;->printStackTrace()V

    goto :goto_3

    .line 257
    .end local v0    # "e":Ljava/io/IOException;
    :catch_1
    move-exception v0

    .line 258
    .local v0, "e":Ljava/lang/NoSuchMethodException;
    invoke-virtual {v0}, Ljava/lang/NoSuchMethodException;->printStackTrace()V

    .line 261
    .end local v0    # "e":Ljava/lang/NoSuchMethodException;
    :goto_2
    nop

    .line 262
    :goto_3
    return-void
.end method

.method public onCreate()V
    .locals 17

    .line 43
    const-string v0, "APPLICATION_CLASS_NAME"

    const/4 v1, 0x0

    .line 45
    .local v1, "appClassName":Ljava/lang/String;
    :try_start_0
    invoke-virtual/range {p0 .. p0}, Lcom/example/protectappnative/ProxyApplication;->getPackageManager()Landroid/content/pm/PackageManager;

    move-result-object v2

    .line 46
    invoke-virtual/range {p0 .. p0}, Lcom/example/protectappnative/ProxyApplication;->getPackageName()Ljava/lang/String;

    move-result-object v3

    const/16 v4, 0x80

    .line 45
    invoke-virtual {v2, v3, v4}, Landroid/content/pm/PackageManager;->getApplicationInfo(Ljava/lang/String;I)Landroid/content/pm/ApplicationInfo;

    move-result-object v2

    .line 48
    .local v2, "applicationInfo":Landroid/content/pm/ApplicationInfo;
    iget-object v3, v2, Landroid/content/pm/ApplicationInfo;->metaData:Landroid/os/Bundle;

    .line 49
    .local v3, "metaData":Landroid/os/Bundle;
    if-eqz v3, :cond_0

    invoke-virtual {v3, v0}, Landroid/os/Bundle;->containsKey(Ljava/lang/String;)Z

    move-result v4

    if-eqz v4, :cond_0

    .line 50
    invoke-virtual {v3, v0}, Landroid/os/Bundle;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0
    :try_end_0
    .catch Landroid/content/pm/PackageManager$NameNotFoundException; {:try_start_0 .. :try_end_0} :catch_0

    move-object v1, v0

    .line 54
    .end local v2    # "applicationInfo":Landroid/content/pm/ApplicationInfo;
    .end local v3    # "metaData":Landroid/os/Bundle;
    :cond_0
    goto :goto_0

    .line 52
    :catch_0
    move-exception v0

    .line 53
    .local v0, "e":Landroid/content/pm/PackageManager$NameNotFoundException;
    invoke-virtual {v0}, Landroid/content/pm/PackageManager$NameNotFoundException;->printStackTrace()V

    .line 62
    .end local v0    # "e":Landroid/content/pm/PackageManager$NameNotFoundException;
    :goto_0
    const/4 v0, 0x0

    new-array v2, v0, [Ljava/lang/Class;

    new-array v3, v0, [Ljava/lang/Object;

    const-string v4, "android.app.ActivityThread"

    const-string v5, "currentActivityThread"

    invoke-static {v4, v5, v2, v3}, Lcom/example/protectappnative/RefInvoke;->invokeStaticMethod(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Class;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v2

    .line 68
    .local v2, "currentActivityThread":Ljava/lang/Object;
    const-string v3, "mBoundApplication"

    invoke-static {v4, v2, v3}, Lcom/example/protectappnative/RefInvoke;->getFieldObject(Ljava/lang/String;Ljava/lang/Object;Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v3

    .line 83
    .local v3, "mBoundApplication":Ljava/lang/Object;
    const-string v5, "android.app.ActivityThread$AppBindData"

    const-string v6, "info"

    invoke-static {v5, v3, v6}, Lcom/example/protectappnative/RefInvoke;->getFieldObject(Ljava/lang/String;Ljava/lang/Object;Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v6

    .line 89
    .local v6, "loadedApkInfo":Ljava/lang/Object;
    const/4 v7, 0x0

    const-string v8, "android.app.LoadedApk"

    const-string v9, "mApplication"

    invoke-static {v8, v9, v6, v7}, Lcom/example/protectappnative/RefInvoke;->setFieldObject(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Object;Ljava/lang/Object;)V

    .line 97
    const-string v7, "mInitialApplication"

    invoke-static {v4, v2, v7}, Lcom/example/protectappnative/RefInvoke;->getFieldObject(Ljava/lang/String;Ljava/lang/Object;Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v9

    .line 103
    .local v9, "oldApplication":Ljava/lang/Object;
    const-string v10, "mAllApplications"

    invoke-static {v4, v2, v10}, Lcom/example/protectappnative/RefInvoke;->getFieldObject(Ljava/lang/String;Ljava/lang/Object;Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v10

    check-cast v10, Ljava/util/ArrayList;

    .line 108
    .local v10, "mAllApplications":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Landroid/app/Application;>;"
    invoke-virtual {v10, v9}, Ljava/util/ArrayList;->remove(Ljava/lang/Object;)Z

    .line 111
    const-string v11, "mApplicationInfo"

    invoke-static {v8, v6, v11}, Lcom/example/protectappnative/RefInvoke;->getFieldObject(Ljava/lang/String;Ljava/lang/Object;Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v11

    check-cast v11, Landroid/content/pm/ApplicationInfo;

    .line 116
    .local v11, "appInfoInLoadedApk":Landroid/content/pm/ApplicationInfo;
    const-string v12, "appInfo"

    invoke-static {v5, v3, v12}, Lcom/example/protectappnative/RefInvoke;->getFieldObject(Ljava/lang/String;Ljava/lang/Object;Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v5

    check-cast v5, Landroid/content/pm/ApplicationInfo;

    .line 122
    .local v5, "appInfoInAppBindData":Landroid/content/pm/ApplicationInfo;
    iput-object v1, v11, Landroid/content/pm/ApplicationInfo;->className:Ljava/lang/String;

    .line 123
    iput-object v1, v5, Landroid/content/pm/ApplicationInfo;->className:Ljava/lang/String;

    .line 145
    const-string v12, "mInstrumentation"

    invoke-static {v4, v2, v12}, Lcom/example/protectappnative/RefInvoke;->getFieldObject(Ljava/lang/String;Ljava/lang/Object;Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v12

    .line 150
    .local v12, "oldInstrumentation":Ljava/lang/Object;
    const/4 v13, 0x2

    new-array v14, v13, [Ljava/lang/Class;

    sget-object v15, Ljava/lang/Boolean;->TYPE:Ljava/lang/Class;

    aput-object v15, v14, v0

    const-class v15, Landroid/app/Instrumentation;

    const/16 v16, 0x1

    aput-object v15, v14, v16

    new-array v13, v13, [Ljava/lang/Object;

    .line 155
    invoke-static {v0}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v15

    aput-object v15, v13, v0

    aput-object v12, v13, v16

    .line 150
    const-string v0, "makeApplication"

    invoke-static {v8, v0, v6, v14, v13}, Lcom/example/protectappnative/RefInvoke;->invokeMethod(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Object;[Ljava/lang/Class;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/app/Application;

    .line 157
    .local v0, "newApp":Landroid/app/Application;
    invoke-static {v4, v7, v2, v0}, Lcom/example/protectappnative/RefInvoke;->setFieldObject(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Object;Ljava/lang/Object;)V

    .line 165
    const-string v7, "mProviderMap"

    invoke-static {v4, v2, v7}, Lcom/example/protectappnative/RefInvoke;->getFieldObject(Ljava/lang/String;Ljava/lang/Object;Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Landroid/util/ArrayMap;

    .line 168
    .local v4, "mProviderMap":Landroid/util/ArrayMap;
    invoke-virtual {v4}, Landroid/util/ArrayMap;->values()Ljava/util/Collection;

    move-result-object v7

    invoke-interface {v7}, Ljava/util/Collection;->iterator()Ljava/util/Iterator;

    move-result-object v7

    .line 169
    .local v7, "iterator":Ljava/util/Iterator;
    :goto_1
    invoke-interface {v7}, Ljava/util/Iterator;->hasNext()Z

    move-result v8

    if-eqz v8, :cond_1

    .line 170
    invoke-interface {v7}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v8

    .line 171
    .local v8, "providerClientRecord":Ljava/lang/Object;
    const-string v13, "android.app.ActivityThread$ProviderClientRecord"

    const-string v14, "mLocalProvider"

    invoke-static {v13, v8, v14}, Lcom/example/protectappnative/RefInvoke;->getFieldObject(Ljava/lang/String;Ljava/lang/Object;Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v13

    .line 175
    .local v13, "localProvider":Ljava/lang/Object;
    const-string v14, "android.content.ContentProvider"

    const-string v15, "mContext"

    invoke-static {v14, v15, v13, v0}, Lcom/example/protectappnative/RefInvoke;->setFieldObject(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Object;Ljava/lang/Object;)V

    .line 180
    .end local v8    # "providerClientRecord":Ljava/lang/Object;
    .end local v13    # "localProvider":Ljava/lang/Object;
    goto :goto_1

    .line 181
    :cond_1
    invoke-super/range {p0 .. p0}, Landroid/app/Application;->onCreate()V

    .line 182
    return-void
.end method
