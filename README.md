<p align="center">
<img src="https://github.com/RoPieee/RoPieee/blob/main/docs/images/logo.png" width="300" title="RoPieee logo">
</p>
<h3 align="center">An easy-to-use Raspberry Pi image for network audio streaming solutions</h3>
<br/>

[![Static Badge](https://img.shields.io/badge/Download%20the%20latest%20release-2025.08.2-blue)](/docs/CHANGELOG.md#2025.08.2)

RoPieee is an image for the Raspberry Pi devices (3, 4 and 5 family) that is capable of running several audio streaming platforms. RoPieee can be seen as an appliance, and as such requires no computer knowledge whatsoever. RoPieee's functionality is often called a 'network bridge'.

## Introduction

RoPieee's web interface supports multiple languages. This project contains the JSON files with 'all' text elements. The english translation (en-US) acts like 'master' file: it is both the default language and acts as fallback when a specific translation cannot be found. 

## Change translations

If you think that some existing translations can be improved, feel free to make a PR.

## Add translation

Adding a translation can be done by opening a PR and introducing a new language file. That's the simple explanation 😅 

Obviously more needs to happen: the language files are shipped with the binary, so only an update to RoPieee itself can 'enable' the new language. Furthermore it needs be correct and complete before the PR is (potentially) accepted. There's a simple shell script, called `check.sh`, which you can run (on a Linux system) that checks the validity of the file and if it is complete.

Finally there's the [TODO](TODO.md) file that shows (possible) remaining items to be translated per file.
