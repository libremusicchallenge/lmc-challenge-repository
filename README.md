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

NEXT
