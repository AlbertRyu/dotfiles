## The motivation

I am always being the kind of person who likes to polish the tools one used. Computer without doubt is the most important tool to me, on which I spend the most of my time. Because of this, my computer is the tool I polished the most, to maximize the productivity.

If I wish to spend so much time polishing my tool, I would better hope that this tool could serve me as long as possible. To reach this aim, there are two main points,

1. Cross-platform availability

    I daily drive a MacBook Air, but I also have a Windows desktop for gaming, and a Raspberry Pi running Debian Linux as my home server. So I really want to avoid mastering three software programs for one purpose (editor e.g.) So I use neo-vim, which could run on any machine with a terminal.

1. Customization transferability

    After spending hundreds of hours doing all the customization, I really not want to repeat this work unnecessarily. So the customization better be easily transferable to a new machine. Here's where the **dotfiles** methodology that caught me eyes.

## The dotfiles

Many of the modern software programs store their user configurations under `.config/` in the home directory. If the setup is easy, the configuration could be a single file, such as `.vimrc` for vim and `.zshrc` for zsh. Some of them create their own folder for this purpose, for example Claude Code create its own `.claude/` to store many things including the user level `CLAUDE.md`.

These files (or folders) are called the dotfiles. Although they played a crucial part controlling the software behavior, the dot before their names make them invisible in most of the file explorer by default. Because most of the time they are not expected to be modified by the users directly. However, we can do that, and if we do that correctly, it grants us better control and better understanding of the behavior of the software. And most importantly, gathering all of them (or only those you modified or cared) into one place, and version controlling them by git made the whole system under your direct control. This could be down from the help the tool `stow`.
