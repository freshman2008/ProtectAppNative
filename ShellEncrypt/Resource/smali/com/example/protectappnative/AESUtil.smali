.class public Lcom/example/protectappnative/AESUtil;
.super Ljava/lang/Object;
.source "AESUtil.java"


# static fields
.field private static final DEFAULT_CIPHER_ALGORITHM:Ljava/lang/String; = "AES/CBC/PKCS5Padding"

.field private static final KEY_ALGORITHM:Ljava/lang/String; = "AES"

.field public static final ZERO_IV:[B

.field private static localKey:[B


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .line 10
    const/16 v0, 0x10

    new-array v0, v0, [B

    fill-array-data v0, :array_0

    sput-object v0, Lcom/example/protectappnative/AESUtil;->ZERO_IV:[B

    .line 15
    const/4 v0, 0x0

    sput-object v0, Lcom/example/protectappnative/AESUtil;->localKey:[B

    return-void

    nop

    :array_0
    .array-data 1
        0x0t
        0x0t
        0x0t
        0x0t
        0x0t
        0x0t
        0x0t
        0x0t
        0x0t
        0x0t
        0x0t
        0x0t
        0x0t
        0x0t
        0x0t
        0x0t
    .end array-data
.end method

.method public constructor <init>()V
    .locals 0

    .line 7
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static decrypt([B)[B
    .locals 2
    .param p0, "content"    # [B

    .line 25
    sget-object v0, Lcom/example/protectappnative/AESUtil;->localKey:[B

    sget-object v1, Lcom/example/protectappnative/AESUtil;->ZERO_IV:[B

    invoke-static {p0, v0, v1}, Lcom/example/protectappnative/AESUtil;->decrypt([B[B[B)[B

    move-result-object v0

    return-object v0
.end method

.method public static decrypt([B[B[B)[B
    .locals 4
    .param p0, "content"    # [B
    .param p1, "key"    # [B
    .param p2, "iv"    # [B

    .line 44
    :try_start_0
    const-string v0, "AES/CBC/PKCS5Padding"

    invoke-static {v0}, Ljavax/crypto/Cipher;->getInstance(Ljava/lang/String;)Ljavax/crypto/Cipher;

    move-result-object v0

    .line 45
    .local v0, "cipher":Ljavax/crypto/Cipher;
    new-instance v1, Ljavax/crypto/spec/SecretKeySpec;

    const-string v2, "AES"

    invoke-direct {v1, p1, v2}, Ljavax/crypto/spec/SecretKeySpec;-><init>([BLjava/lang/String;)V

    .line 46
    .local v1, "secretKeySpec":Ljavax/crypto/spec/SecretKeySpec;
    new-instance v2, Ljavax/crypto/spec/IvParameterSpec;

    invoke-direct {v2, p2}, Ljavax/crypto/spec/IvParameterSpec;-><init>([B)V

    .line 47
    .local v2, "ivParameterSpec":Ljavax/crypto/spec/IvParameterSpec;
    const/4 v3, 0x2

    invoke-virtual {v0, v3, v1, v2}, Ljavax/crypto/Cipher;->init(ILjava/security/Key;Ljava/security/spec/AlgorithmParameterSpec;)V

    .line 48
    invoke-virtual {v0, p0}, Ljavax/crypto/Cipher;->doFinal([B)[B

    move-result-object v3
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 49
    .local v3, "result":[B
    return-object v3

    .line 50
    .end local v0    # "cipher":Ljavax/crypto/Cipher;
    .end local v1    # "secretKeySpec":Ljavax/crypto/spec/SecretKeySpec;
    .end local v2    # "ivParameterSpec":Ljavax/crypto/spec/IvParameterSpec;
    .end local v3    # "result":[B
    :catch_0
    move-exception v0

    .line 51
    .local v0, "ex":Ljava/lang/Exception;
    sget-object v1, Ljava/lang/System;->out:Ljava/io/PrintStream;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-class v3, Lcom/example/protectappnative/AESUtil;

    invoke-virtual {v3}, Ljava/lang/Class;->getName()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v3, "->"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    .line 53
    .end local v0    # "ex":Ljava/lang/Exception;
    const/4 v0, 0x0

    return-object v0
.end method

.method public static encrypt([B)[B
    .locals 2
    .param p0, "content"    # [B

    .line 21
    sget-object v0, Lcom/example/protectappnative/AESUtil;->localKey:[B

    sget-object v1, Lcom/example/protectappnative/AESUtil;->ZERO_IV:[B

    invoke-static {p0, v0, v1}, Lcom/example/protectappnative/AESUtil;->encrypt([B[B[B)[B

    move-result-object v0

    return-object v0
.end method

.method public static encrypt([B[B[B)[B
    .locals 4
    .param p0, "content"    # [B
    .param p1, "key"    # [B
    .param p2, "iv"    # [B

    .line 30
    :try_start_0
    const-string v0, "AES/CBC/PKCS5Padding"

    invoke-static {v0}, Ljavax/crypto/Cipher;->getInstance(Ljava/lang/String;)Ljavax/crypto/Cipher;

    move-result-object v0

    .line 31
    .local v0, "cipher":Ljavax/crypto/Cipher;
    new-instance v1, Ljavax/crypto/spec/SecretKeySpec;

    const-string v2, "AES"

    invoke-direct {v1, p1, v2}, Ljavax/crypto/spec/SecretKeySpec;-><init>([BLjava/lang/String;)V

    .line 32
    .local v1, "secretKeySpec":Ljavax/crypto/spec/SecretKeySpec;
    new-instance v2, Ljavax/crypto/spec/IvParameterSpec;

    invoke-direct {v2, p2}, Ljavax/crypto/spec/IvParameterSpec;-><init>([B)V

    .line 33
    .local v2, "ivParameterSpec":Ljavax/crypto/spec/IvParameterSpec;
    const/4 v3, 0x1

    invoke-virtual {v0, v3, v1, v2}, Ljavax/crypto/Cipher;->init(ILjava/security/Key;Ljava/security/spec/AlgorithmParameterSpec;)V

    .line 34
    invoke-virtual {v0, p0}, Ljavax/crypto/Cipher;->doFinal([B)[B

    move-result-object v3
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 35
    .local v3, "result":[B
    return-object v3

    .line 36
    .end local v0    # "cipher":Ljavax/crypto/Cipher;
    .end local v1    # "secretKeySpec":Ljavax/crypto/spec/SecretKeySpec;
    .end local v2    # "ivParameterSpec":Ljavax/crypto/spec/IvParameterSpec;
    .end local v3    # "result":[B
    :catch_0
    move-exception v0

    .line 37
    .local v0, "ex":Ljava/lang/Exception;
    sget-object v1, Ljava/lang/System;->out:Ljava/io/PrintStream;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-class v3, Lcom/example/protectappnative/AESUtil;

    invoke-virtual {v3}, Ljava/lang/Class;->getName()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v3, "->"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    .line 39
    .end local v0    # "ex":Ljava/lang/Exception;
    const/4 v0, 0x0

    return-object v0
.end method

.method public static init(Ljava/lang/String;)V
    .locals 1
    .param p0, "key"    # Ljava/lang/String;

    .line 17
    invoke-virtual {p0}, Ljava/lang/String;->getBytes()[B

    move-result-object v0

    sput-object v0, Lcom/example/protectappnative/AESUtil;->localKey:[B

    .line 18
    return-void
.end method

.method public static main([Ljava/lang/String;)V
    .locals 7
    .param p0, "args"    # [Ljava/lang/String;

    .line 57
    const-string v0, "hello"

    .line 58
    .local v0, "content":Ljava/lang/String;
    const-string v1, "1122334455667788"

    .line 59
    .local v1, "key":Ljava/lang/String;
    sget-object v2, Ljava/lang/System;->out:Ljava/io/PrintStream;

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "content:"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    .line 60
    invoke-virtual {v0}, Ljava/lang/String;->getBytes()[B

    move-result-object v2

    invoke-virtual {v1}, Ljava/lang/String;->getBytes()[B

    move-result-object v3

    sget-object v4, Lcom/example/protectappnative/AESUtil;->ZERO_IV:[B

    invoke-static {v2, v3, v4}, Lcom/example/protectappnative/AESUtil;->encrypt([B[B[B)[B

    move-result-object v2

    .line 61
    .local v2, "s1":[B
    invoke-virtual {v1}, Ljava/lang/String;->getBytes()[B

    move-result-object v3

    sget-object v4, Lcom/example/protectappnative/AESUtil;->ZERO_IV:[B

    invoke-static {v2, v3, v4}, Lcom/example/protectappnative/AESUtil;->decrypt([B[B[B)[B

    move-result-object v3

    .line 62
    .local v3, "s2":[B
    const/4 v4, 0x0

    .local v4, "i":I
    :goto_0
    array-length v5, v3

    if-ge v4, v5, :cond_0

    .line 63
    sget-object v5, Ljava/lang/System;->out:Ljava/io/PrintStream;

    aget-byte v6, v3, v4

    invoke-virtual {v5, v6}, Ljava/io/PrintStream;->println(I)V

    .line 62
    add-int/lit8 v4, v4, 0x1

    goto :goto_0

    .line 65
    .end local v4    # "i":I
    :cond_0
    return-void
.end method
