dotSprinkler
===============

This is a collection of scripts that make it easy to quickly deploy dotfiles.  I created it because I want to spend more time writing code and less time configuring my environment.  The idea is that I can sit down at an unconfigured linux terminal, retrieve dotSprinkler from github, run bootstrap.sh, and have all my custom configurations be put in place (sprinkled).  If I make a change to those configurations, I can push them back to github so that the new version is available elsewhere.

How it works
-------------------

Typically, dotSprinkler creates hard links between the packaged dotfiles (e.g. `dotSprinkler/_bash_aliases`) and the expected location of those files on the target system (e.g. `~/.bash_aliases`).  If the packaged configs are directories (`e.g. dotSprinkler/_vim/`) symlinks are created instead.  When the system goes to look for configurations, it sees the dotSprinkler configurations instead.  Changes to the dotFiles (whether made in the dotSprinkler directory, or in-place in the system) are ultimately stored in the same place, and can be pushed back to github so that they can be used elsewhere.

Installation
-----------

    git clone git@github.com:MatrixManAtYrService/dotSprinkler.git
    # See "personalization" below
    dotSprinkler/bootstrap.sh
    


Usage
-----

- **bootstrap.sh** is the "magic button" script that installs software and configures it (requires apt).  It runs configure.sh, prompts the user to authenticate with Evernote, and then runs personalize.sh.

- **configure.sh** assumes that all of the repository-based work has been done and sprinkles the dotfiles.  It also runs any install-scripts that aren't covered by apt's repositories (these are located in ./install/).

- **clearExisting.sh** removes whatever lives at the target locations for the dotfiles.  If they're links, they're simple deleted.  If they're config files, they're backed up.

- **restoreBackups** restores backups made by clearExisting.sh

- **locations.sh** maps dotfiles to their various locations in the target system, it is called by several of the other scripts.

- **personalize.sh** exists because I didn't want to put my SSH keys on github.  It fetches the more personal aspects of my configuration from Evernote (which may not be the best place for them, but we're talking low-security keys here) and puts them in place. [Coming Soon]

Alternatives
------------

There are several things that do this job, mine probably isn't the best.  See https://dotfiles.github.io/ for a long list of projects to do the same thing.  I decided to build it myself as an exercise in becoming more familliar with bash.  As a first-real-scripting-project, it probably isn't as elegant or stable as it could be.  You've been warned.

Personalization
---------------

I've tried to structure this so that other people can fork it for their own purposes.  Filenames and paths are stored primarily in locations.sh (a few others live in configuration.sh).  They're all stored in arrays towards the top of the file, which should make adding/removing dotfiles/install scripts/etc. pretty straightforward.

If you do this, I recommend skimming each dotfile first.  There are probably some things that I want that you don't.  For example, what kind of lunatic wants `set -o vi` in their .bashrc?  This guy!  But probably not you.  I recommend removing that line from `dotSprinkler/_bash_aliases` *before* running bootstrap.sh so that you don't get tangled up with settings you're not used to.

I'm going to try to move personal stuff to personalize.sh, but I'll probably get lazy.  At the time of this writing, `_gitconfig` contains my work e-mail address.  Please don't go checking your code in with my e-mail--you'll end up making me look good, and then people will start expecting more of me.  Instead, skim these files before forking a copy so that you don't end up looking like me.  Thanks.


License
-------

This software is provided as is (aren't most things?).  The only "particular purpose" it is warrantied to be "fit" for is taking up space in memory somewhere.  You can do whatever you like with it, but if you redistribute it you should remove any references to the original author so that spooks from the future can't use them to track him down in the event that dotSprinkles grows up to become Skynet.  Also, please don't encourage its growing up to become Skynet.

