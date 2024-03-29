# nvim-workbench
A workbench plugin for you to write your thoughts down without leaving the project and the editor :)

## Disclaimer

**VERSION: This plugin should work fine with neovim v0.6.0 and above**

This is my very first neovim plugin and also my first time coding in Lua. So, **use this at your own risk :)**

I am still learning and will love to make this plugin better, any suggestions or feature requests are welcome :)

Also, if you have found any bugs, feel free to report it as well :)

Cheers and have a nice day! :)

## Background

I have built this plugin specifically to fit with my personal workflow. For every features or tasks that I am working on,
I always love to break them down into details. Before this, I was using Obsidian workbench, until I started following
[ThePrimeagen](https://github.com/ThePrimeagen) and [TJ DeVries](https://github.com/tjdevries/). I have watched many of their
YouTube videos and also their streams on Twitch and I have learned some much from them and the community. In the end, I was inspired
to try and built my own plugin. There's no better way to start than building something that I will use everyday. I am super motivated
to build this so that I don't have to keep switching desktop to look at my task again, I can just pop up a workbench in Neovim!
Of course, there are many task management plugins out there, [vim-bujo](https://github.com/vuciv/vim-bujo) is the one that inspired
me to built something similar with my personal tweak. So, let's get started!

## What this plugin does?

1. It provides workbenches to your project and also its git branches (currently only support project with Git initialized)
2. It's totally up to you on what you want to do with the workbenches :)
3. For me personally, I use the project wise workbench to write down all the very high level stuff for a particular project.
4. Then I will use branch specific workbench to write down the tasks that I am working on in that particular git branch.
3. This way, I can keep my mind clear from remembering what I needed to do, I can easily pull the workbench up and everything is inside.
4. Video below is showing that each of your projects will have its own project specific workbench

https://user-images.githubusercontent.com/40255418/115995386-8ae54900-a60d-11eb-9c84-12a8e31ff585.mp4

5. Other than just a project specific workbench, you will also get branch specific workbench as shown in the video below

https://user-images.githubusercontent.com/40255418/116779498-139a3400-aaa9-11eb-9adf-da9f16fb9f1c.mp4

## Installation
1. For installation using `vim-plug` simply add this line to your vimrc then run PlugInstall
```vim
:Plug 'marcushwz/nvim-workbench'
```
2. After that there are a few key mappings for you to set.
```vim
" Below are my personal key mappings
" <Plug>ToggleProjectWorkbench let you toggle project specific workbench
nmap <leader>bp <Plug>ToggleProjectWorkbench
" <Plug>ToggleBranchWorkbench let you toggle the branch specific workbench
nmap <leader>bb <Plug>ToggleBranchWorkbench

" <Plug>WorkbenchToggleCheckbox allows you to add/toggle the checkbox
" - testing -> - [ ] testing
" - [ ] testing -> - [x] testing
" - [x] testing -> - [ ] testing
nmap <leader><CR> <Plug>WorkbenchToggleCheckbox
```

3. To specify your own custom path to store markdown files (please make sure the directory exists)
```vim
  " in lua
  vim.g.workbench_storage_path = os.getenv("HOME") .. "/Documents/Notes/"
  " in vim
  let g:workbench_storage_path = getenv("HOME") . "/Documents/Notes/"
```

4. To specify your own workbench border, default is double. (Currently only support Neovim nightly)
```vim
  " available option are single, double, shadow or check the help page for custom option
  " :h nvim_open_win and look for the border variable
  " in lua
  vim.g.workbench_border = 'single'
  vim.g.workbench_border = { "+", "+" }
  " in vim
  let g:workbench_border = 'single'
  let g:workbench_border = ["+", "+"]
```
