This document is meant to serve as a brief guide on submitting contributions to the GitHub repository. 

## Forking the repository 

To first add your own changes to the repository, you will have to fork it. To do this, navigate to the repository’s GitHub page where a Fork button is found at the top of the page. This will create a fork of the repository to your own GitHub account.  
Once this is done, you can locate the newly created fork on your account, which can then be cloned to your local machine by navigating to the code button on your forked repository page and opening it in the GitHub Desktop app. From here, you can freely edit your fork of the project. 
From a terminal, this can also be done from using the following command (replace ‘YOUR_USERNAME’ with your GitHub username): 


`git clone https://github.com/YOUR_USERNAME/dream-big` 

  
## Creating a branch: 
When developing new features, you will need to create a new branch of the project. On GitHub desktop, this can be done by selecting the dream-big repository and navigating to the ‘current branch’ tab, where there will be an option to create a new branch. 
A branch can also be created using a terminal with the following command:

`git branch –c BRANCHNAME` 

## Making commits: 

Commits can be made via GitHub desktop or by using a terminal with the following command: 

`git commit –m “example message”` 

When making commits, including a commit message with a header is mandatory. Including a body is recommended, and including a footer is optional. Make sure to include a header, a body, and a footer in the following format: 

```text 
<header> 
<BLANK LINE> 
<body> 
<BLANK LINE> 
<footer> 
```

The header must also be in the following format: 

`<type>(<scope>): <short summary>` 

Make sure to write commits in the imperative mood and not the indicative mood. E.g. “fix an issue”, not “fixed an issue” and “add new feature”, not “added new feature”. 

## Syncing your repository and creating a pull request 

Before you apply your own changes, your local repository may not be synced with the host repository. To do this, navigate to your forked repository on GitHub. From there, you will be able to sync the fork with that of the main repository. Afterwards, you can now pull from your newly updated forked repository to the repository on your local machine.  
This can also be done through a terminal using the following commands: 

```text 
git push     # push to origin 
git pull     # pull from upstream 
```

In this context, origin refers to your own fork, while upstream is the original repository that has been forked. 
When you are ready to contribute your changes to the project, you can create a pull request from the initial repository’s page. Once created, the admins of the repository will be able to view your commits, and approve it to be merged. Once your pull request is merged, you can delete your feature branch and create a new one to repeat this process when adding new features. 
