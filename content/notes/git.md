---
title: "Git"
date: 2018-10-28T22:12:11+08:00
markup: "pandoc"
---

## Submodule

### 删除 submodule

```
git submodule deinit -f -- a/submodule
rm -rf .git/modules/a/submodule
git rm -f a/submodule
```
