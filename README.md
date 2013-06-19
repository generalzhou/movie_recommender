##Movie Recommender

This is a WIP machine learning project I started while at Dev Bootcamp. The goal of this project is to build a Netflix like recommender for movies. You enter in your ratings for 10+ movies (from 1-5), and the algorithm will score how likely you will like all the movies in its database of about 1,600, and tell you the top 10 movies you should watch.  

This program uses movie rating data from http://www.grouplens.org/node/73 to generate similarity scores between movies. This score is used to determine how likely you are to like movie 2 if you like movie 1, and is calculated using a method called Pearson Correlation. Much of this was adapted from Python to Ruby from the book Programming Collective Intelligence by O'Reilly.  
