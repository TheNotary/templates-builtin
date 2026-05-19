# foo-bar

TODO: Describe your project

## Installation

You can install this program onto your local machine by following these instructions

```
$  mvn clean install
$  cp target/foo-bar ~/bin/
```

## Usage

Usage is simple as long as you have ~/bin in your $PATH variable:

```
$  foo-bar
```

## Debugging

Debugging is done with the eclipse IDE.  To import this project, use the `mvn eclipse:eclipse` command to create the reuired `.project` and `.settings` files.


## Proper Usage

Java isn't really a programming language that's intended for easy usage.  They try to stay away from reading OS environment variables, for instance, because it makes the system 'dependant on the platform'.  If you're a really big fan of platforms, this news might bum you out, but the ideal solution in the java world is to use `properties`.


```
$  java -Dlaunchtime_property=pewpew -jar target/test-app-0.0.0-SNAPSHOT.jar
```
