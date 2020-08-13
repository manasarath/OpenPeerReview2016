# OpenPeerReview2016

The Open Peer Review (OPR) project is carried out in the academic year 2015-16 under the supervision of Prof. Peiling Wang at the School of Information Sciences, University of Tennessee, Knoxville (UTK). Here are some of the research papers which includes these https://content.sciendo.com/configurable/contentpage/journals$002fjdis$002f1$002f4$002farticle-p60.xml ; https://ieeexplore.ieee.org/abstract/document/7991608; https://www.ideals.illinois.edu/handle/2142/89432

The project comprises of following:
  - Data Scrapping Project
  - Qualitative Resarch Project 

The Data Scrapping project was first begun while I was taking the Text Mining class at Haslam Business School. In this project I tried to study to what extent the scientific community adopt the Open Peer Review Publication Model. To understand this phonomena, specific URls were taken from OPR journal F1000 and specific HTML/CSS elements were extracted from the publication URLs. To run this code, perform the following steps:

  1. Start with installing Selector Gadget extension on your Chrome browser
  2. Install the package rvest on RStudio and run it
  
 Go on the particular URL and later click on Selector Gadget to see the HTML/CSS element you want to extract. After figuring out the element go ahead and put the element in the R code. Later fetch the list of URLs, where you want the code to run and extract the elements from those URLs. Once the elements from those URLs are extracted you could go ahead and get the writable file which woulld consist of the required elements from those URLs. 
 
 According to this code, the extracted elements from this code include:
 
-Author name: .authors
-Affliations: .affiliations
-Grant Information: .grant-information
-Data Availability: #article1-body
-Date of the referee report: .referee-report-details-box
-Status of the referee report: .referee-report-status-line
-Referee name and affliation: .padding-left div
-Date of author's information: .commenter-role
-Referee report content: .referee-report-content
-Author response: .comment-content

This work was disseminated in several top tier journal and conference venues. Few collaborators of this project include with researchers at University of Wisconsin, Milwaukee. 

The qualitative part of the OPR project started while I was taking Qual Research Methods class with Dr. Erin Whiteside at UTK. As the part of this project, I interviewed scientists and researchers at Oak Ridge Research Lab and UTK. The results and findings are disseminated in https://ieeexplore.ieee.org/abstract/document/7991608


















