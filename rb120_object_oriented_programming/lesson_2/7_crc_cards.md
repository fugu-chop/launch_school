# CRC Cards

## Table of Contents
- [What is a CRC card?](#what-is-a-crc-card)
- [Summary](#summary)

### What is a CRC Card?
__Class Responsibility Collaborator (CRC)__ cards is a way to _model the various classes of a program_. While it started out as a teaching tool, it's become a real-world tool to flesh out and design classes and map interactions between classes. Usually, we draw up some quick CRC cards as part of the brainstorming session to come up with our classes.

Here are the components of a CRC card:
![CRC Card Diagram](https://d1b1wr57ag5rdp.cloudfront.net/images/oop/lesson2/crc_card_components_2.jpg)

Below is an example of a CRC card for the `Human` card:
![Human Card Diagram](https://d1b1wr57ag5rdp.cloudfront.net/images/oop/lesson2/human_crc_card.png)

And if we create a CRC card for all the classes in the RPS game, we have a CRC model.
![Other Card Diagram](https://d1b1wr57ag5rdp.cloudfront.net/images/oop/lesson2/crc_model.png)

Finally, we have our CRC card for the `RPSGame` class:
![RPS Card Diagram](https://d1b1wr57ag5rdp.cloudfront.net/images/oop/lesson2/rpsgame_crc_card.png)

One thing to note here is that we didn't list all the methods in the `RPSGame` class. We __only want to list the public methods__ that can or should be called from outside the class. Methods like `display_welcome_message` is used internally by the `play` method, and is more of an implementation detail.

### Summary
CRC cards are yet another tool to help you organize your ideas. You don't have to use it if you don't find it helpful. In general, you should follow the below approach.
- Write a description of the problem and extract major nouns and verbs.
- Make an initial guess at organizing the verbs and nouns into methods and classes/modules, then do a spike to explore the problem with temporary code.
- When you have a better idea of the problem, model your thoughts into CRC cards.

Don't be afraid to make mistakes; remember, there is likely no "right" design. Feel free to tweak this approach to fit your style.
