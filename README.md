# Project 6 - *PictureShare*

**PictureShare** is a photo sharing app using Parse as its backend.

Time spent: **15** hours spent in total

## User Stories

The following **required** functionality is completed:

- [X] User can sign up to create a new account using Parse authentication
- [X] User can log in and log out of his or her account
- [X] The current signed in user is persisted across app restarts
- [X] User can take a photo, add a caption, and post it to "Instagram"
- [X] User can view the last 20 posts submitted to "Instagram"

The following **optional** features are implemented:

- [X] Show the username and creation time for each post
- [X] After the user submits a new post, show a progress HUD while the post is being uploaded to Parse.
- [X] User Profiles:
   - [X] Allow the logged in user to add a profile photo
   - [X] Display the profile photo with each post
   - [X] Tapping on a post's username or profile photo goes to that user's profile page

The following **additional** features are implemented:



Please list two areas of the assignment you'd like to **discuss further with your peers** during the next class (examples include better ways to implement something, how to extend your app in certain ways, etc):

1. I would like to discuss how everyone has organized data on the Cloud(DB). How did they save information so that retrieval could be done with minimum number of calls possible.
2. I would like to discuss on the things like how to put information related to an user like the profile image etc up to data. when the user change the profile image, are we deleting the existing image on the cloud and uploading the new image or is there an option to update the existing information. 

## Video Walkthrough 

Here's a walkthrough of implemented user stories:

<img src='http://i.imgur.com/utUQ17a.gif' title='PictureShare' width='' alt='Video Walkthrough' />

GIF created with [LiceCap](http://www.cockos.com/licecap/).

## Notes

Describe any challenges encountered while building the app.
1. I wanted to know how to save images of different resolution so that basing on the connection speed I can load the images.
2. I had some some problem with understanding PFImage(ParseUI) stuff but the Mentors were very helpful.


## License

    Copyright [2016] [Rahul Krishna Vasantham]

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.