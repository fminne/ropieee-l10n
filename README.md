<p align="center">
<img src="https://github.com/RoPieee/RoPieee/blob/main/docs/images/logo.png" width="300" title="RoPieee logo">
</p>
<h3 align="center">An easy-to-use Raspberry Pi image for network audio streaming solutions</h3>
<br/>

[![Static Badge](https://img.shields.io/badge/Download%20the%20latest%20release-2025.10.1-blue)](/docs/CHANGELOG.md#2025.10.1)

RoPieee is an image for the Raspberry Pi devices (3, 4 and 5 family) that is capable of running several audio streaming platforms. RoPieee can be seen as an appliance, and as such requires no computer knowledge whatsoever. RoPieee's functionality is often called a 'network bridge'.

## Introduction

RoPieee's web interface supports multiple languages. This project contains the JSON files with 'all' text elements. The english translation (en-US) acts like 'master' file: it is both the default language and acts as fallback when a specific translation cannot be found. 

## How does it work?

A translation file has keys, subkeys and values. The keys are being used by the software to identify a specific text and should *not* be changed in any way.
So for example, in this snippet:

```
"MENU": {
        "SYSTEM": "System",
```

MENU is the key, SYSTEM is the subkey and "System" is the value (the actual text). So in this example, only the value "System" can be changed.

In some strings you will see something like this:

```
Welcome to {{.constants.GLOBAL_PROD_NAME}}
```

The text between double brackets (```{{..}}```) refers to a variable that the software will inject during displaying. Do *not* change these in any way.

When loading a page of RoPieee's webinterface the software will look up the text by using the key and subkey. If it can't find the text, it will fall back to its default (English from the en-US.json file).

When texts are being added by the software (because of a new feature for example), the corresponding texts will be added to the master file. The [TODO](TODO.md) file will show what's missing (if any) in the other translation files.

## Add translation

Adding a new translation can be done by opening a PR and introducing a new language file. That's the simple explanation 😅

A PR can also be used to propose changes to already existing files.

Before a PR is going to (potentially) accepted, make sure the file is a valid JSON file. And if you're running on Linux you can use a simple shell script, called `check.sh`, to check the validity and file contents.
When everything looks good the PR might be accepted.

To summarize, keep this in mind when contributing:
- only one language (change) per PR
- make sure the JSON file is valid
- make sure you don't introduce unknown keys

The language files are shipped with the binary, so only an update to RoPieee itself can 'enable' a new language or publish changes.

Finally there's the [TODO](TODO.md) file that shows (possible) remaining items to be translated per file.
