.class Lcom/example/protectappnative/ProxyApplication$1;
.super Ljava/lang/Object;
.source "ProxyApplication.java"

# interfaces
.implements Ljava/io/FilenameFilter;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/example/protectappnative/ProxyApplication;->attachBaseContext(Landroid/content/Context;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/example/protectappnative/ProxyApplication;


# direct methods
.method constructor <init>(Lcom/example/protectappnative/ProxyApplication;)V
    .locals 0
    .param p1, "this$0"    # Lcom/example/protectappnative/ProxyApplication;

    .line 236
    iput-object p1, p0, Lcom/example/protectappnative/ProxyApplication$1;->this$0:Lcom/example/protectappnative/ProxyApplication;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public accept(Ljava/io/File;Ljava/lang/String;)Z
    .locals 1
    .param p1, "dir"    # Ljava/io/File;
    .param p2, "name"    # Ljava/lang/String;

    .line 239
    const-string v0, ".dex"

    invoke-virtual {p2, v0}, Ljava/lang/String;->endsWith(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 240
    const/4 v0, 0x1

    return v0

    .line 242
    :cond_0
    const/4 v0, 0x0

    return v0
.end method
