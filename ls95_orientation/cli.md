# The Command Line

## Table of Contents
- [Why should I care?](#why-should-i-care)
- [The display](#the-display)
- [Commands and arguments](#commands-and-arguments)
- [Useful commands](#useful-commands)
- [Environmental variables](#environmental-variables)
- [$PATH](#$path)
- [Permissions](#permissions)
- [Root user and Sudo](#root-user-and-sudo)

### Why should I care?
I'll need to install software, compile and run code, and perform system administration tasks, like scheduling tasks (cron jobs), restart servers, monitor system resources and other things. 

### The display
In most bash terminals, you'll see `[user]@[hostname]: [current_directory]$`, where `hostname` is the computer's name. 

### Commands and arguments
Commands let us tell the computer what to do. They take the structure `[command][arguments...]`
- Arguments are additional pieces of information passed to commands. 
- Arguments can take the form of flags, which start with a dash for abbreviated flags (e.g. `-a`), or double dash for full words (e.g. `--format`)
- Arguments can be chained together (e.g. `-czf`)
We can use `man [command]` to find a description of the command and it's arguments. 
- Press `q` to exit `man`.

### Useful commands
- `cat`, `more`, `less`, `head`, `tail` are all examples of useful commands that let us inspect the contents of a file. 
- `pwd` prints the working directory (i.e. where we are in the context of the computer's file system).
- `mv` allows us to *rename or move* files.
    - `mv file1.txt file2.txt` is renaming a file
    - `mv file1.txt folder/` is moving a file to another folder
    - `mv folder/file1.txt file2.txt` is moving a file to the current directory and renaming it.
- `rm` deletes things. 
    - We need to use a `-r` flag to delete the contents of a non-empty folder (i.e. it's files and subdirectories). 

###### UNIX File system commands
- `/` is the root directory
- `./` is the current directory
- `../` is one level up from the current directory
- `../..` is two levels up from the current directory
- `/home/ubuntu` is specifying a folder called `ubuntu`, in a directory called `home`, which is in the `root` directory.
- `home/ubuntu` is specifying a folder called `ubuntu` inside our *current* directory, which is called `home`. 
- `ls` lists files and folders in the current directory
    - `ls /*ot` uses the `*`, or `splat`, which allows for string matching. In this example, this is searching for any folder ending in `ot`. 

Generally speaking, if we get an error about a directory, we can use a `-r` flag to remedy it. 

### Environmental variables
We can reference variables through the command line. We can list these through use of the `env` keyword. We are also able to set our own variables.

###### Setting variables on the fly
When we set variables on the fly, they only persist for the current session. 
```
variableA="something"  # No spaces!
echo $variableA        # We appended a $ sign to the variable
=> something
```
We can't easily use the variable on the same line that we define it, because variables are evaluated *before setting the variable occurs*. 

###### Setting permanent variables
We can do this by defining variables in our `.zshrc` and `.zprofile` files for `zsh`. These can be accessed via `ls -a ~`

### $PATH
`PATH` is a variable that provides context for the CLI to run commands like `cd` and `echo`, without having the user specify where those commands exist on the file system. 

When we type in a word into the command line that doesn't start with `/`, `~` or `.` (since those are partsh to files or directories), the command line will search directories listed in the PATH environmental variable. 

We are able to add directories to the `PATH` variable through the `~/.zshrc` file like:
`export PATH="/directory/to/executable:$PATH"`

The colon and `$PATH` preserves old `PATH` locations and allows the specified directory to take higher precedence than other directories. 

### Permissions
Permission structures are linked to files and directories. If we run `ls -lah` on a folder, we can see a jumble of letters next to each file & directory, like `drwxr-xr-x`.
![Screenshot of Permissions](https://media.geeksforgeeks.org/wp-content/uploads/Screenshot-572.png)

- The first character is usually `-` (indicating a file) or `d` (indicating a directory)
- The next string represent permissions for __*users*__, then __*groups*__, then __*other*__, in groups of three characters. These three characters indicate the permissions a user/group/other has over that file or directory. 
    - The first column indicates `read`, the second column indicates `write` permissions and the 3rd column indicates `execute` permission.
    - `r` = read, `w` = write, `x` = execute, `-` = permission not granted
- The next column is the *user*, and the column to the right of that is the *group name*.

It's important to note that permissions are __not__ bestowed on users or groups - files and directories are assigned groups and users, and *permissions are tied to those files and directories*.

Permissions are divided into:
- Ownership
    - User
    - Group
    - Other
- Access types
    - Read (r)
    - Write (w)
    - Execute (x)

Each level of ownership can be granted to __any or all access types__. We can see which groups a user belongs to using `groups [username]`

###### Setting permissions
- `chmod u-w text.txt` => This is removing `w`rite access to the `text.txt` file for the `u`ser.
- `chmod g+x text.txt` => This is granting e`x`ecute access for `text.txt` to the `g`roup.
- `chmod +w text.txt`  => This is granting `w`rite access to `text.txt` for users, groups and other. 

We can also set permissions for users, groups and other all at once, using
- `chmod ugo text.txt`, where `u`, `g` and `o` represent a single digit from 0-7 for users, groups and other.
    - `0` => No permissions
    - `1` => Execute
    - `2` => Write
    - `3` => Write & execute (1 + 2)
    - `4` => Read
    - `5` => Read & execute (4 + 1)
    - `6` => Read & write (4 + 2)
    - `7` => Read, write & execute (4 + 2 + 1)

### Root User and Sudo 
The `root` user has `7` access to all files and directories. As such, it's generally __not recommended__ to log in as the root user, unless strictly necessary to avoid the risk of deleting something you shouldn't. 

Otherwise, we can use the `sudo` keyword in conjunction with a command to execute some action that requires root user privilege. Server admins are able to access detailed logs for when `sudo` is used.