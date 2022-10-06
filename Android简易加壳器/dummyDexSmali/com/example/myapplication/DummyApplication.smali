.class public Lcom/example/myapplication/DummyApplication;
.super Landroid/app/Application;
.source "DummyApplication.java"


# static fields
.field private static ApplicationContext:Landroid/content/Context; = null

.field private static final TAG:Ljava/lang/String; = "ayuan-log"

.field private static final src_dex_filename:Ljava/lang/String; = "src.dex"


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 23
    invoke-direct {p0}, Landroid/app/Application;-><init>()V

    return-void
.end method

.method private copyDex(Ljava/lang/String;)Ljava/lang/String;
    .locals 8
    .param p1, "dexName"    # Ljava/lang/String;

    .line 182
    invoke-virtual {p0}, Lcom/example/myapplication/DummyApplication;->getAssets()Landroid/content/res/AssetManager;

    move-result-object v0

    .line 184
    .local v0, "as":Landroid/content/res/AssetManager;
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {p0}, Lcom/example/myapplication/DummyApplication;->getFilesDir()Ljava/io/File;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    sget-object v2, Ljava/io/File;->separator:Ljava/lang/String;

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    .line 186
    .local v1, "path":Ljava/lang/String;
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "copyDex: path: "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    const-string v3, "ayuan-log"

    invoke-static {v3, v2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 190
    :try_start_0
    new-instance v2, Ljava/io/FileOutputStream;

    invoke-direct {v2, v1}, Ljava/io/FileOutputStream;-><init>(Ljava/lang/String;)V

    .line 192
    .local v2, "out":Ljava/io/FileOutputStream;
    invoke-virtual {v0, p1}, Landroid/content/res/AssetManager;->open(Ljava/lang/String;)Ljava/io/InputStream;

    move-result-object v3

    .line 194
    .local v3, "is":Ljava/io/InputStream;
    const/16 v4, 0x400

    new-array v4, v4, [B

    .line 195
    .local v4, "buffer":[B
    const/4 v5, 0x0

    .line 196
    .local v5, "len":I
    :goto_0
    invoke-virtual {v3, v4}, Ljava/io/InputStream;->read([B)I

    move-result v6

    move v5, v6

    const/4 v7, -0x1

    if-eq v6, v7, :cond_0

    .line 197
    const/4 v6, 0x0

    invoke-virtual {v2, v4, v6, v5}, Ljava/io/FileOutputStream;->write([BII)V

    goto :goto_0

    .line 200
    :cond_0
    invoke-virtual {v2}, Ljava/io/FileOutputStream;->close()V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 204
    .end local v2    # "out":Ljava/io/FileOutputStream;
    .end local v3    # "is":Ljava/io/InputStream;
    .end local v4    # "buffer":[B
    .end local v5    # "len":I
    nop

    .line 205
    return-object v1

    .line 201
    :catch_0
    move-exception v2

    .line 202
    .local v2, "e":Ljava/lang/Exception;
    invoke-virtual {v2}, Ljava/lang/Exception;->printStackTrace()V

    .line 203
    const-string v3, ""

    return-object v3
.end method

.method private getLoader(Ljava/lang/String;)Ldalvik/system/DexClassLoader;
    .locals 4
    .param p1, "dexPath"    # Ljava/lang/String;

    .line 169
    new-instance v0, Ldalvik/system/DexClassLoader;

    .line 171
    invoke-virtual {p0}, Lcom/example/myapplication/DummyApplication;->getCacheDir()Ljava/io/File;

    move-result-object v1

    invoke-virtual {v1}, Ljava/io/File;->toString()Ljava/lang/String;

    move-result-object v1

    sget-object v2, Lcom/example/myapplication/DummyApplication;->ApplicationContext:Landroid/content/Context;

    .line 172
    invoke-virtual {v2}, Landroid/content/Context;->getApplicationInfo()Landroid/content/pm/ApplicationInfo;

    move-result-object v2

    iget-object v2, v2, Landroid/content/pm/ApplicationInfo;->nativeLibraryDir:Ljava/lang/String;

    .line 173
    invoke-virtual {p0}, Lcom/example/myapplication/DummyApplication;->getClassLoader()Ljava/lang/ClassLoader;

    move-result-object v3

    invoke-direct {v0, p1, v1, v2, v3}, Ldalvik/system/DexClassLoader;-><init>(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/ClassLoader;)V

    .line 175
    .local v0, "dexClassLoader":Ldalvik/system/DexClassLoader;
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "getLoader: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    const-string v2, "ayuan-log"

    invoke-static {v2, v1}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 176
    return-object v0
.end method

.method private loadApplication()V
    .locals 18

    .line 45
    const-string v0, "APPLICATION_CLASS_NAME"

    const-string v1, "demo"

    const/4 v2, 0x0

    .line 47
    .local v2, "appClassName":Ljava/lang/String;
    :try_start_0
    invoke-virtual/range {p0 .. p0}, Lcom/example/myapplication/DummyApplication;->getPackageManager()Landroid/content/pm/PackageManager;

    move-result-object v3

    invoke-virtual/range {p0 .. p0}, Lcom/example/myapplication/DummyApplication;->getPackageName()Ljava/lang/String;

    move-result-object v4

    const/16 v5, 0x80

    invoke-virtual {v3, v4, v5}, Landroid/content/pm/PackageManager;->getApplicationInfo(Ljava/lang/String;I)Landroid/content/pm/ApplicationInfo;

    move-result-object v3

    .line 49
    .local v3, "ai":Landroid/content/pm/ApplicationInfo;
    iget-object v4, v3, Landroid/content/pm/ApplicationInfo;->metaData:Landroid/os/Bundle;

    .line 50
    .local v4, "bundle":Landroid/os/Bundle;
    if-eqz v4, :cond_0

    invoke-virtual {v4, v0}, Landroid/os/Bundle;->containsKey(Ljava/lang/String;)Z

    move-result v5

    if-eqz v5, :cond_0

    .line 51
    invoke-virtual {v4, v0}, Landroid/os/Bundle;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    move-object v2, v0

    .line 59
    .end local v3    # "ai":Landroid/content/pm/ApplicationInfo;
    .end local v4    # "bundle":Landroid/os/Bundle;
    goto :goto_0

    .line 53
    .restart local v3    # "ai":Landroid/content/pm/ApplicationInfo;
    .restart local v4    # "bundle":Landroid/os/Bundle;
    :cond_0
    const-string v0, "have no application class name"

    invoke-static {v1, v0}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I
    :try_end_0
    .catch Landroid/content/pm/PackageManager$NameNotFoundException; {:try_start_0 .. :try_end_0} :catch_0

    .line 54
    return-void

    .line 56
    .end local v3    # "ai":Landroid/content/pm/ApplicationInfo;
    .end local v4    # "bundle":Landroid/os/Bundle;
    :catch_0
    move-exception v0

    .line 57
    .local v0, "e":Landroid/content/pm/PackageManager$NameNotFoundException;
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "error:"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-static {v0}, Landroid/util/Log;->getStackTraceString(Ljava/lang/Throwable;)Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v1, v3}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 58
    invoke-virtual {v0}, Landroid/content/pm/PackageManager$NameNotFoundException;->printStackTrace()V

    .line 61
    .end local v0    # "e":Landroid/content/pm/PackageManager$NameNotFoundException;
    :goto_0
    const/4 v0, 0x0

    new-array v3, v0, [Ljava/lang/Class;

    new-array v4, v0, [Ljava/lang/Object;

    const-string v5, "android.app.ActivityThread"

    const-string v6, "currentActivityThread"

    invoke-static {v5, v6, v3, v4}, Lcom/example/myapplication/ReflectUtils;->invokeStaticMethod(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Class;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v3

    .line 64
    .local v3, "currentActivityThread":Ljava/lang/Object;
    const-string v4, "mBoundApplication"

    invoke-static {v5, v3, v4}, Lcom/example/myapplication/ReflectUtils;->getFieldOjbect(Ljava/lang/String;Ljava/lang/Object;Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v4

    .line 67
    .local v4, "mBoundApplication":Ljava/lang/Object;
    const-string v6, "android.app.ActivityThread$AppBindData"

    const-string v7, "info"

    invoke-static {v6, v4, v7}, Lcom/example/myapplication/ReflectUtils;->getFieldOjbect(Ljava/lang/String;Ljava/lang/Object;Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v7

    .line 71
    .local v7, "loadedApkInfo":Ljava/lang/Object;
    const-string v8, "android.app.LoadedApk"

    const-string v9, "mApplication"

    const/4 v10, 0x0

    invoke-static {v8, v9, v7, v10}, Lcom/example/myapplication/ReflectUtils;->setFieldOjbect(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Object;Ljava/lang/Object;)V

    .line 73
    const-string v9, "mInitialApplication"

    invoke-static {v5, v3, v9}, Lcom/example/myapplication/ReflectUtils;->getFieldOjbect(Ljava/lang/String;Ljava/lang/Object;Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v11

    .line 77
    .local v11, "oldApplication":Ljava/lang/Object;
    nop

    .line 78
    const-string v12, "mAllApplications"

    invoke-static {v5, v3, v12}, Lcom/example/myapplication/ReflectUtils;->getFieldOjbect(Ljava/lang/String;Ljava/lang/Object;Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v12

    check-cast v12, Ljava/util/ArrayList;

    .line 80
    .local v12, "mAllApplications":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Landroid/app/Application;>;"
    invoke-virtual {v12, v11}, Ljava/util/ArrayList;->remove(Ljava/lang/Object;)Z

    .line 82
    nop

    .line 83
    const-string v13, "mApplicationInfo"

    invoke-static {v8, v7, v13}, Lcom/example/myapplication/ReflectUtils;->getFieldOjbect(Ljava/lang/String;Ljava/lang/Object;Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v13

    check-cast v13, Landroid/content/pm/ApplicationInfo;

    .line 85
    .local v13, "appinfo_In_LoadedApk":Landroid/content/pm/ApplicationInfo;
    nop

    .line 86
    const-string v14, "appInfo"

    invoke-static {v6, v4, v14}, Lcom/example/myapplication/ReflectUtils;->getFieldOjbect(Ljava/lang/String;Ljava/lang/Object;Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v6

    check-cast v6, Landroid/content/pm/ApplicationInfo;

    .line 88
    .local v6, "appinfo_In_AppBindData":Landroid/content/pm/ApplicationInfo;
    iput-object v2, v13, Landroid/content/pm/ApplicationInfo;->className:Ljava/lang/String;

    .line 89
    iput-object v2, v6, Landroid/content/pm/ApplicationInfo;->className:Ljava/lang/String;

    .line 90
    const/4 v14, 0x2

    new-array v15, v14, [Ljava/lang/Class;

    sget-object v16, Ljava/lang/Boolean;->TYPE:Ljava/lang/Class;

    aput-object v16, v15, v0

    const-class v16, Landroid/app/Instrumentation;

    const/16 v17, 0x1

    aput-object v16, v15, v17

    new-array v14, v14, [Ljava/lang/Object;

    .line 93
    invoke-static {v0}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v16

    aput-object v16, v14, v0

    aput-object v10, v14, v17

    .line 90
    const-string v0, "makeApplication"

    invoke-static {v8, v0, v7, v15, v14}, Lcom/example/myapplication/ReflectUtils;->invokeMethod(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Object;[Ljava/lang/Class;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/app/Application;

    .line 94
    .local v0, "app":Landroid/app/Application;
    invoke-static {v5, v9, v3, v0}, Lcom/example/myapplication/ReflectUtils;->setFieldOjbect(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Object;Ljava/lang/Object;)V

    .line 98
    const-string v8, "mProviderMap"

    invoke-static {v5, v3, v8}, Lcom/example/myapplication/ReflectUtils;->getFieldOjbect(Ljava/lang/String;Ljava/lang/Object;Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v5

    check-cast v5, Landroid/util/ArrayMap;

    .line 101
    .local v5, "mProviderMap":Landroid/util/ArrayMap;
    invoke-virtual {v5}, Landroid/util/ArrayMap;->values()Ljava/util/Collection;

    move-result-object v8

    invoke-interface {v8}, Ljava/util/Collection;->iterator()Ljava/util/Iterator;

    move-result-object v8

    .line 102
    .local v8, "it":Ljava/util/Iterator;
    :goto_1
    invoke-interface {v8}, Ljava/util/Iterator;->hasNext()Z

    move-result v9

    if-eqz v9, :cond_1

    .line 103
    invoke-interface {v8}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v9

    .line 104
    .local v9, "providerClientRecord":Ljava/lang/Object;
    const-string v10, "android.app.ActivityThread$ProviderClientRecord"

    const-string v14, "mLocalProvider"

    invoke-static {v10, v9, v14}, Lcom/example/myapplication/ReflectUtils;->getFieldOjbect(Ljava/lang/String;Ljava/lang/Object;Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v10

    .line 107
    .local v10, "localProvider":Ljava/lang/Object;
    const-string v14, "android.content.ContentProvider"

    const-string v15, "mContext"

    invoke-static {v14, v15, v10, v0}, Lcom/example/myapplication/ReflectUtils;->setFieldOjbect(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Object;Ljava/lang/Object;)V

    .line 109
    .end local v9    # "providerClientRecord":Ljava/lang/Object;
    .end local v10    # "localProvider":Ljava/lang/Object;
    goto :goto_1

    .line 111
    :cond_1
    new-instance v9, Ljava/lang/StringBuilder;

    invoke-direct {v9}, Ljava/lang/StringBuilder;-><init>()V

    const-string v10, "app:"

    invoke-virtual {v9, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v9

    invoke-virtual {v9}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v9

    invoke-static {v1, v9}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    .line 113
    invoke-virtual {v0}, Landroid/app/Application;->onCreate()V

    .line 114
    return-void
.end method

.method private loadDex()V
    .locals 4

    .line 117
    const-string v0, "ayuan-log"

    const-string v1, "DummyApplication.attachBaseContext: \u5f00\u59cb\u52a0\u8f7d"

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 119
    const-string v1, "src.dex"

    invoke-direct {p0, v1}, Lcom/example/myapplication/DummyApplication;->copyDex(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    .line 121
    .local v1, "dexPath":Ljava/lang/String;
    invoke-direct {p0, v1}, Lcom/example/myapplication/DummyApplication;->getLoader(Ljava/lang/String;)Ldalvik/system/DexClassLoader;

    move-result-object v2

    .line 123
    .local v2, "dexClassLoader":Ldalvik/system/DexClassLoader;
    invoke-direct {p0, v2}, Lcom/example/myapplication/DummyApplication;->replaceClassLoader(Ldalvik/system/DexClassLoader;)V

    .line 124
    const-string v3, "DummyApplication.attachBaseContext: \u52a0\u8f7d\u7ed3\u675f"

    invoke-static {v0, v3}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 125
    return-void
.end method

.method private replaceClassLoader(Ldalvik/system/DexClassLoader;)V
    .locals 12
    .param p1, "dexClassLoader"    # Ldalvik/system/DexClassLoader;

    .line 132
    :try_start_0
    const-string v0, "android.app.ActivityThread"

    invoke-static {v0}, Ljava/lang/Class;->forName(Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v0

    .line 134
    .local v0, "clzActivityThread":Ljava/lang/Class;
    const-string v1, "currentActivityThread"

    const/4 v2, 0x0

    new-array v3, v2, [Ljava/lang/Class;

    invoke-virtual {v0, v1, v3}, Ljava/lang/Class;->getDeclaredMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v1

    .line 136
    .local v1, "methodCurrentActivityThread":Ljava/lang/reflect/Method;
    const/4 v3, 0x0

    new-array v2, v2, [Ljava/lang/Object;

    invoke-virtual {v1, v3, v2}, Ljava/lang/reflect/Method;->invoke(Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v2

    .line 139
    .local v2, "sCurrentActivityThread":Ljava/lang/Object;
    const-string v3, "android.app.ActivityThread$AppBindData"

    invoke-static {v3}, Ljava/lang/Class;->forName(Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v3

    .line 141
    .local v3, "clzAppBinData":Ljava/lang/Class;
    const-string v4, "mBoundApplication"

    invoke-virtual {v0, v4}, Ljava/lang/Class;->getDeclaredField(Ljava/lang/String;)Ljava/lang/reflect/Field;

    move-result-object v4

    .line 143
    .local v4, "fieldBoundApplication":Ljava/lang/reflect/Field;
    const/4 v5, 0x1

    invoke-virtual {v4, v5}, Ljava/lang/reflect/Field;->setAccessible(Z)V

    .line 144
    invoke-virtual {v4, v2}, Ljava/lang/reflect/Field;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v6

    .line 147
    .local v6, "mBoundApplication":Ljava/lang/Object;
    const-string v7, "android.app.LoadedApk"

    invoke-static {v7}, Ljava/lang/Class;->forName(Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v7

    .line 149
    .local v7, "clzLoadedApk":Ljava/lang/Class;
    const-string v8, "info"

    invoke-virtual {v3, v8}, Ljava/lang/Class;->getDeclaredField(Ljava/lang/String;)Ljava/lang/reflect/Field;

    move-result-object v8

    .line 151
    .local v8, "fieldInfo":Ljava/lang/reflect/Field;
    invoke-virtual {v8, v5}, Ljava/lang/reflect/Field;->setAccessible(Z)V

    .line 152
    invoke-virtual {v8, v6}, Ljava/lang/reflect/Field;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v9

    .line 155
    .local v9, "info":Ljava/lang/Object;
    const-string v10, "java.lang.ClassLoader"

    invoke-static {v10}, Ljava/lang/Class;->forName(Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v10

    .line 157
    .local v10, "clzClassLoader":Ljava/lang/Class;
    const-string v11, "mClassLoader"

    invoke-virtual {v7, v11}, Ljava/lang/Class;->getDeclaredField(Ljava/lang/String;)Ljava/lang/reflect/Field;

    move-result-object v11

    .line 159
    .local v11, "fieldClassLoader":Ljava/lang/reflect/Field;
    invoke-virtual {v11, v5}, Ljava/lang/reflect/Field;->setAccessible(Z)V

    .line 160
    invoke-virtual {v11, v9, p1}, Ljava/lang/reflect/Field;->set(Ljava/lang/Object;Ljava/lang/Object;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 163
    .end local v0    # "clzActivityThread":Ljava/lang/Class;
    .end local v1    # "methodCurrentActivityThread":Ljava/lang/reflect/Method;
    .end local v2    # "sCurrentActivityThread":Ljava/lang/Object;
    .end local v3    # "clzAppBinData":Ljava/lang/Class;
    .end local v4    # "fieldBoundApplication":Ljava/lang/reflect/Field;
    .end local v6    # "mBoundApplication":Ljava/lang/Object;
    .end local v7    # "clzLoadedApk":Ljava/lang/Class;
    .end local v8    # "fieldInfo":Ljava/lang/reflect/Field;
    .end local v9    # "info":Ljava/lang/Object;
    .end local v10    # "clzClassLoader":Ljava/lang/Class;
    .end local v11    # "fieldClassLoader":Ljava/lang/reflect/Field;
    goto :goto_0

    .line 161
    :catch_0
    move-exception v0

    .line 162
    .local v0, "e":Ljava/lang/Exception;
    invoke-virtual {v0}, Ljava/lang/Exception;->printStackTrace()V

    .line 165
    .end local v0    # "e":Ljava/lang/Exception;
    :goto_0
    return-void
.end method


# virtual methods
.method protected attachBaseContext(Landroid/content/Context;)V
    .locals 0
    .param p1, "base"    # Landroid/content/Context;

    .line 31
    invoke-super {p0, p1}, Landroid/app/Application;->attachBaseContext(Landroid/content/Context;)V

    .line 32
    sput-object p1, Lcom/example/myapplication/DummyApplication;->ApplicationContext:Landroid/content/Context;

    .line 33
    invoke-direct {p0}, Lcom/example/myapplication/DummyApplication;->loadDex()V

    .line 34
    return-void
.end method

.method public onCreate()V
    .locals 0

    .line 39
    invoke-super {p0}, Landroid/app/Application;->onCreate()V

    .line 40
    invoke-direct {p0}, Lcom/example/myapplication/DummyApplication;->loadApplication()V

    .line 41
    return-void
.end method
