#!/bin/bash
git fetch f2fs

find . -not -path '*/\.*' -name '*f2fs*' | grep -v 'update_f2fs\|recovery\|ramdisk' | while read f2fs; do rm -rf $f2fs; git checkout f2fs/dev -- $f2fs; done

rm -rf fs/f2fs
git checkout f2fs/dev -- fs/f2fs

git log --oneline f2fs/linux-3.4 | head -1 | awk '{print $1}' | while read patch; do git cherry-pick --no-commit $patch; done
git cherry-pick --no-commit 28839767e994bab811137a81c37d0c06980086ff
git cherry-pick --no-commit 767fa230f1c815a68b0388a7a5a13d79fd140c1a
git cherry-pick --no-commit d8f39f6aa999f546c3061c220fbba57c0479cbb3
git status
