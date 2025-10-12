# Interview Questions and AnswersS: 

### Basic Level: 

1. *What is Git?*
A: Git is a distributed version control system that tracks changes in source code during software development.

2. *What is the difference between Git and GitHub?*
A: Git is a version control system, while GitHub is a web-based platform that uses Git for version control. GitHub provides a hosting service for software development projects using Git.

3. *How do you initialize a Git repository?*
A: You can use the command git init to initialize a Git repository in a directory.

4. *What is a commit in Git?*
A: A commit is a snapshot of changes made to a Git repository. It represents a specific point in the project's history.

5. *How do you add changes to the staging area?*
A: Use the command git add <filename> to add changes to the staging area.

6. *How do you commit changes in Git?*
A: The command git commit -m "Commit message" is used to commit changes with a message describing the changes.
Intermediate Level:

7. *Explain the difference between Git merge and Git rebase.*
_A: Git merge combines changes from different branches, while Git rebase integrates changes by moving or combining a sequence of commits._

8. *What is a branch in Git?*
A: A branch in Git is a lightweight movable pointer to a commit. It allows you to work on different features or bug fixes independently.

9. *How do you resolve merge conflicts in Git?*
A: You can resolve merge conflicts by editing the conflicting files, marking them as resolved, and then completing the merge with git commit.

10. *Explain the purpose of Git clone.*
A: git clone is used to create a copy of a remote repository on your local machine.

11. *How do you undo the last commit in Git?*
A: The command git reset HEAD^ can be used to undo the last commit. This command resets the HEAD to the previous commit.


### Advanced Level:

12. *What is Git rebase interactive mode?*
A: Interactive rebase (git rebase -i) allows you to modify commit history interactively, such as reordering, editing, or squashing commits.

13. *Explain the Git flow branching model.*
A: Git flow is a branching model that defines a standard set of branches and their purpose (e.g., feature, release, hotfix) to manage a project's development process.

14. *How do you tag a release in Git?*
A: You can use the git tag command to tag a specific commit, indicating a point in the history as a release.

15. *What is Git bisect used for?*
A: Git bisect is a command used for binary search through the commit history to find the commit that introduced a bug.

16. *Explain the difference between Git pull and Git fetch.*
_A: Git pull fetches changes from a remote repository and merges them into the current branch, while git fetch only fetches changes but does not automatically merge them._

_Git fetch downloads the latest changes from the remote repository to your local repository, but it does not merge those changes into your current working branch. This means that you can review the changes before merging them into your working branch.

Git pull, on the other hand, downloads the latest changes from the remote repository and merges them into your current working branch. This means that you can use git pull to quickly update your local repository with the latest changes from the remote repository._ 

17. *What command do you use to change the existing commit message?*
_A:
```
git commit --amend -m "New commit message"

git push --force
```

