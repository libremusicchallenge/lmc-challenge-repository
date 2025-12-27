# Libre Music Challenge - Challenge Repository

## Overview

Repository of challenges organized in three categories

- Past: past challenges
- Present: current challenge
- Future: future challenges

The idea is that the community can populate the repository with future
challenges.  At each round a script can randomly select a challenge in
the future category and moves it to the present category.
Simultaneously, the present challenge gets moved to the past category.

## Challenge Description

Each challenge is described by a JSON file.  In the case of a future
challenge the file name is formatted as

```
<CHALLENGE_NAME>.json
```

In the case of a present and past challenge the file name is formatted
as

```
LMC<ROUND_IDX> - <DATE> - <CHALLENGE_NAME>.json
```

where `<DATE>` has the format `YYYY-MM-DD` and indicates the start
date of the challenge.

The JSON fields are described as followed:

NEXT

## Prerequisites

- [qj](https://jqlang.org/)

## Usage

### Randomly Select Challenge

To select the next challenge call the following script

```bash
./randomly-select-challenge.sh
```

which will randomly select a challenge, move it to the
[present](present) directory (after moving the present one to the
[past](past) directory) and complete whatever JSON fields must be
completed, such as `rules`, `prizes`, etc.  It will also rename the
challenge file

```
<CHALLENGE>.json
```

into

```
LMC<ROUND_NUMBER> - <DATE> - <CHALLENGE NAME>.json
```

### Create Future Challenge

To faciliate creating future challenges, a script is provided to walk
the user through the process.  To do that, type the following

```bash
./create-future-challenge.sh
```

then the user is prompted to provide the challenge name, short and
long descriptions, as well as recommended git commands and github
processes to create a branch and submit a pull request.

Note that JSON files of future challenges do not need to contain all
required fields of a challenge.  Indeed, these fields will
automatically be inserted at selection time.

NEXT: write script to help create challenge.
