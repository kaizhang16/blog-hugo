---
title: "GPG"
date: 2019-03-02T22:02:39+08:00
markup: "pandoc"
---

# 基本操作

```
gpg --list-keys  # 列出公钥
gpg --gen-key  # 生成新密钥对

gpg --list-secret-keys --keyid-format LONG  # 列出私钥
gpg --armor --output ${filename} --export-secret-keys ${私钥 ID}  # 导出私钥
gpg --armor --export ${私钥 ID}  # 导出公钥

gpg --import ${filename}  # 导入私钥
```