# GitHub Hexo Action

<a href="https://github.com/marketplace/actions/hexo-action"><img alt="View Action" src="https://img.shields.io/badge/action-marketplace-blue.svg?logo=github&color=orange"></a>
<a href="https://opensource.org/licenses/MIT"><img alt="License: MIT" src="https://img.shields.io/badge/License-MIT-green.svg?logo=github"></a>

This GitHub Actions for automatic generate and deploy hexo-based blog.

Fork from [sma11black/hexo-action](sma11black/hexo-action).

Thanks to  @sma11black.

Just a test, I am not proficient at build a github action, so this is just a test and for deploying my blog. 

Hope it will work well, and oneday when I learn how to build an action fluently and perfectly, I will perfect it. 

:cry::cry::cry::cry::cry::cry:

## Usage
### Example workflow - hexo deploy
On every `push` to this repo, generate hexo sites and publish on `username.github.io` repo.

```yaml
name: Deploy

on: [push]

jobs:
  build:
    runs-on: ubuntu-latest
    name: A job to deploy blog.
    steps:
    - name: Checkout
      uses: actions/checkout@v1
      with:
        submodules: true # Checkout private submodules(themes or something else).
    
    # Caching dependencies to speed up workflows. (GitHub will remove any cache entries that have not been accessed in over 7 days.)
    - name: Cache node modules
      uses: actions/cache@v1
      id: cache
      with:
        path: node_modules
        key: ${{ runner.os }}-node-${{ hashFiles('**/package-lock.json') }}
        restore-keys: |
          ${{ runner.os }}-node-
    - name: Install Dependencies
      if: steps.cache.outputs.cache-hit != 'true'
      run: npm ci
    
    # Deploy hexo blog website.
    - name: Deploy
      id: deploy
      uses: scutLMG/hexo-action@v0.3.0
      with:
        deploy_key: ${{ secrets.DEPLOY_KEY }}
        user_name: your github username  # (or delete this input setting to use bot account)
        user_email: your github useremail  # (or delete this input setting to use bot account)
        commit_msg: ${{ github.event.head_commit.message }}  # (or delete this input setting to use hexo default settings)
    # Use the output from the `deploy` step(use for test action)
    - name: Get the output
      run: |
        echo "${{ steps.deploy.outputs.notify }}"
```

