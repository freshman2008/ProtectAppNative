.class public Lcom/example/protectappnative/FileManager;
.super Ljava/lang/Object;
.source "FileManager.java"


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 15
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static releaseAssetsFile(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;Ljava/lang/reflect/Method;)Ljava/io/File;
    .locals 9
    .param p0, "ctx"    # Landroid/content/Context;
    .param p1, "assetFile"    # Ljava/lang/String;
    .param p2, "releaseFile"    # Ljava/lang/String;
    .param p3, "decMethod"    # Ljava/lang/reflect/Method;

    .line 25
    invoke-virtual {p0}, Landroid/content/Context;->getAssets()Landroid/content/res/AssetManager;

    move-result-object v0

    .line 27
    .local v0, "manager":Landroid/content/res/AssetManager;
    const/4 v1, 0x0

    :try_start_0
    invoke-virtual {v0, p1}, Landroid/content/res/AssetManager;->open(Ljava/lang/String;)Ljava/io/InputStream;

    move-result-object v2

    .line 28
    .local v2, "is":Ljava/io/InputStream;
    new-instance v3, Ljava/io/ByteArrayOutputStream;

    invoke-direct {v3}, Ljava/io/ByteArrayOutputStream;-><init>()V

    .line 30
    .local v3, "os":Ljava/io/ByteArrayOutputStream;
    const/16 v4, 0x400

    new-array v4, v4, [B

    .line 31
    .local v4, "buff":[B
    :goto_0
    invoke-virtual {v2, v4}, Ljava/io/InputStream;->read([B)I

    move-result v5

    move v6, v5

    .local v6, "len":I
    const/4 v7, -0x1

    const/4 v8, 0x0

    if-eq v5, v7, :cond_0

    .line 32
    invoke-virtual {v3, v4, v8, v6}, Ljava/io/ByteArrayOutputStream;->write([BII)V

    goto :goto_0

    .line 35
    :cond_0
    if-eqz p3, :cond_1

    const/4 v5, 0x1

    new-array v5, v5, [Ljava/lang/Object;

    invoke-virtual {v3}, Ljava/io/ByteArrayOutputStream;->toByteArray()[B

    move-result-object v7

    aput-object v7, v5, v8

    invoke-virtual {p3, v1, v5}, Ljava/lang/reflect/Method;->invoke(Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v5

    check-cast v5, [B

    check-cast v5, [B

    goto :goto_1

    :cond_1
    invoke-virtual {v3}, Ljava/io/ByteArrayOutputStream;->toByteArray()[B

    move-result-object v5

    .line 36
    .local v5, "dec":[B
    :goto_1
    invoke-virtual {v2}, Ljava/io/InputStream;->close()V

    .line 37
    invoke-virtual {v3}, Ljava/io/ByteArrayOutputStream;->close()V

    .line 39
    new-instance v7, Ljava/io/File;

    invoke-direct {v7, p2}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    .line 40
    .local v7, "outFile":Ljava/io/File;
    new-instance v8, Ljava/io/FileOutputStream;

    invoke-direct {v8, v7}, Ljava/io/FileOutputStream;-><init>(Ljava/io/File;)V

    .line 41
    .local v8, "fos":Ljava/io/FileOutputStream;
    invoke-virtual {v8, v5}, Ljava/io/FileOutputStream;->write([B)V

    .line 42
    invoke-virtual {v8}, Ljava/io/FileOutputStream;->flush()V

    .line 43
    invoke-virtual {v8}, Ljava/io/FileOutputStream;->close()V
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_2
    .catch Ljava/lang/IllegalAccessException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Ljava/lang/reflect/InvocationTargetException; {:try_start_0 .. :try_end_0} :catch_0

    .line 44
    return-object v7

    .line 49
    .end local v2    # "is":Ljava/io/InputStream;
    .end local v3    # "os":Ljava/io/ByteArrayOutputStream;
    .end local v4    # "buff":[B
    .end local v5    # "dec":[B
    .end local v6    # "len":I
    .end local v7    # "outFile":Ljava/io/File;
    .end local v8    # "fos":Ljava/io/FileOutputStream;
    :catch_0
    move-exception v2

    .line 50
    .local v2, "e":Ljava/lang/reflect/InvocationTargetException;
    invoke-virtual {v2}, Ljava/lang/reflect/InvocationTargetException;->printStackTrace()V

    goto :goto_3

    .line 47
    .end local v2    # "e":Ljava/lang/reflect/InvocationTargetException;
    :catch_1
    move-exception v2

    .line 48
    .local v2, "e":Ljava/lang/IllegalAccessException;
    invoke-virtual {v2}, Ljava/lang/IllegalAccessException;->printStackTrace()V

    .end local v2    # "e":Ljava/lang/IllegalAccessException;
    goto :goto_2

    .line 45
    :catch_2
    move-exception v2

    .line 46
    .local v2, "e":Ljava/io/IOException;
    invoke-virtual {v2}, Ljava/io/IOException;->printStackTrace()V

    .line 51
    .end local v2    # "e":Ljava/io/IOException;
    :goto_2
    nop

    .line 52
    :goto_3
    return-object v1
.end method
