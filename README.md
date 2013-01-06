# Marmalade MKB Source File Listing Generator

This is a script which allows you to automatically populate a list
of source files/directories in your MKB files. The source files may
be organized into a subdirectory tree in any way you see fit.

Marmalade's MKB wildcard support is very weak currently when it
comes to wanting to specify source files which are organized
into many different directories and subdirectories. This script
helps work around this limitation.

## Usage

You first create a template file **mkb_template.txt** for your MKB.
This will contain all the normal things found in an MKB file like 
your defines, deployment options, includepaths, options, etc. For
your files section you simply write it like:

	files
	{
		%%SOURCE_FILES%%
	}


The **%%SOURCE_FILES%%** tag will be replaced with a listing like
the following after running the **mkb_generate** script:

	(../src) [src] '*.*'
	(../src/subdir) [src/subdir] '*.*'
	(../src/another/sub/dir) [src/another/sub/dir] '*.*'
	(../lib/eastl) [lib/eastl] '*.*'
	(../lib/eastl/include/EABase) [lib/eastl/include/EABase] '*.*'
	... etc ...
	... etc ...

This kind of MKB source file listing ensures that under Visual Studio
and Xcode that your project, as shown in the IDE, will have it's
source files listed under appropriate folders/groups exactly like how
your source files are organized on disk.

The **mkb_generate** script does not do any other preprocessing of the
MKB file template. It only scans for the %%SOURCE_FILES%% tag and
replaces it. Every other line is copied to the output MKB file as-is.

**mkb_generate** will overwrite the existing MKB file if one is there.

## Configuration

At the top of the **mkb_generate** script there are some config
variables that can and should be modified to your needs.

+ **DIR\_SOURCES** is a space-separated list of directories that are to be scanned for source files. All child directories of the directories specified here will also be scanned and do not need to be individually specified.
+ **DIR\_SOURCES\_EXCLUDE** is a space-separated list of directories that are contained somewhere in DIR_SOURCES that should *not* be included in the output MKB file listing. Any child directories of these will also be excluded.
+ **PROJECT\_NAME** is the name of the project. This will become the name of the output MKB file. For example, if this is set to "MyProject" the output MKB file will be MyProject.mkb. By default, PROJECT\_NAME will be automatically set based on a specific assumption about the way the project is structured. More on this below.

The rest of the config variables probably don't need to be modified.

## How PROJECT_NAME is Automatically Set

This is largely based on my own personal conventions and may not
apply to everyone. If that is the case, you can just manually set
the value to whatever you need.

By default, the **mkb_generate** script will automatically set the
**PROJECT_NAME** value based on an assumed directory structure
for your project, similar to the one shown below which is how all
my projects are typically set up:

	/some/directory/containing
		/ProjectName
			/src           [all source files, cpp/c/h]
			/lib           [third-party library source files, cpp/c/h]
			/assets        [textures, audio, models, etc]
			/marmalade     [marmalade stuff: mkb_generate, output MKB file, ICFs, build output, etc]

which would mean that the **mkb_generate** script is located at:

	/some/directory/containing/ProjectName/marmalade/mkb_generate

In this kind of structure, **PROJECT_NAME** would be set to 
"ProjectName" because mkb_generate is located at
ProjectName/marmalade/mkb_generate.
