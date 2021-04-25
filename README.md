# nvim-workbench
A workbench plugin inspired by Obsidian Workbench with some tweak.

## Disclaimer

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
to build this so that I don't have to keep switching desktop to look at my task again, I can just pop up a floating video in Neovim!
Of course, there are many task management plugins out there, [vim-bujo](https://github.com/vuciv/vim-bujo) is the one that inspired
me to built something similar with my personal tweak. So, let's get started!

## What this plugin does?

1. It provides a projects specific workbench (currently only support project with Git initialized)
2. You can do anything inside the workbench, for me, I love to write down all the tasks I needed to do for a feature request or bug fixes.
3. This way, I can keep my mind clear from remembering what I needed to do, I can easily pull the workbench up and everything is inside.
4. Below is a short GIF showing you how I use workbench in nvim, note that, each of your project will have their own workbench :)

![2021-04-25_11-08-01 (1)](https://user-images.githubusercontent.com/40255418/115979247-63639180-a5b7-11eb-9890-800f19e33f19.gif)

## What this plugin can't do?
**Disclaimer**: *When I was building this plugin, I never thought I will open source it, but yeah why not?*
1. There are no support for you to define your own path to store all the markdown file, it is defaulted to `~/.cache/`
2. There are no support for you to customize the floating window such as: width, height, border ...

- Both of these are on my list in the enhancement section below.

## Installation
1. For installation using `vim-plug` simply add this line to your vimrc then run PlugInstall
```vim
:Plug 'marcushwz/nvim-workbench'
```
2. After that there are 3 key mappings for you to set.
```vim
" Below are my personal key mappings
" <Plug>ToggleWorkbench let you toggle the floating window (which is your workbench)
nmap <leader>b <Plug>ToggleWorkbench

" <Plug>WorkbenchAddCheckbox allows you to easily turned a list in markdown to a checkbox
" - testing -> - [ ] testing
" * testing -> * [ ] testing
" testing -> [ ] testing
nmap ,a <Plug>WorkbenchAddCheckbox

" <Plug>WorkbenchToggleCheckbox allows you to toggle the checkbox
" - [ ] testing -> - [x] testing
" - [x] testing -> - [ ] testing
nmap <leader><CR> <Plug>WorkbenchToggleCheckbox
```

## Enhancement
- [ ] Ability to set your own path to store all the workbench file
- [ ] Ability to customize the workbench floating window
- [ ] Improve code quality
