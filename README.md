**MUMT 307 Final Project**

_Katie Lin (she/her)_

_5 May 2023_

# Description

My final project reproduces a subtractive synthesizer in MATLAB from first principles, using the LP-BLIT to reduce aliasing across the entire waveform.

# Motivation

I've been fascinated by lower-level concepts for a while -- both in mathematics and in computer science.
I'm of the strong opinion that the best way to improve comprehension of something is to derive it from first principles.
So, when I had to pick a final project for MUMT 307, it was an easy choice to try to work with some lower-level algorithms, in order to better understand the process of synthesis.
We didn't have much of a chance to cover subtractive synthesis in class, so that's what I decided to focus on.

# Research

When looking into subtractive synthesis, my first resource was the [MUMT 307 class notes](https://www.music.mcgill.ca/~gary/307/week5/bandlimited.html).
Reading through the section helped me with comprehension, but more importantly, it pointed me towards an improved implemetation of BLIT: [LP-BLIT](http://www.dafx17.eca.ed.ac.uk/papers/DAFx17_paper_59.pdf).
This implementation, which allows for control over stop-band roll-off and the lowpass filter cutoff frequency, reduces aliasing.

The LP-BLIT paper outlined an implementation strategy that I ended up following fairly closely.
Much of my time spent researching was actually me building a level of understanding to wrap my head around the goals outlined in the paper; I spent more time than I originally anticipated decoding the standard variable names that they used and reading other papers that the original referenced, oftentimes trading back and forth between implementation and research.
For instance, in order to understand how the overlap calculations worked, I ended up having to draw several diagrams --- first to understand how the pulses would interact with each other, and how the window had to change to match, then to figure out how to best implement the pulse calculations as a series of pointers along a single array to save computation time.

A brief digression to explain the goal of the paper, and by extension, my project:
Bandlimited impulse trains (BLITs) are the foundation of subtractive synthesis.
Using just a BLIT and a leaky integrator, a sine, square, and triangle wave (and thus arbitrary signals) can all be generated and stepped through in the time domain.
In order to model an impulse train mathematically, what is known as a `sinc` function is often used --- this function, being the result of integrating an impulse, can model a pulse, thus creating a pulse train.
However, due to the lack of control over the generated impulse train using this method (there are few degrees of freedom --- mostly just the distance between pulses), it is harder to prevent aliasing within generated waveforms.
The *Hammerich pulse* is a pulse that, as mentioned above, allows for an additional degree of freedom, giving additional control over aliasing.
Practically, it works in a similar manner to the `sinc` function.

# Implementation

My plans for actual implementation were originally to implement the LP-BLIT and waveform generation algorithms in MATLAB first, then rewrite a second implementation in a low-level language like C++ that I could then use in an application like JACK as a real sound device.
As I worked on the project, the scope of my goals shifted due to unexpected issues -- I ended needing a lot more depth of understanding than I originally expected, which left me with less time to actually work on the implementation process.

The implementation that I ended up with was a set of MATLAB functions -- one per file -- that are together able to generate a Hammerich pulse, and using that create a BLIT and standard waves.
They're fully vectorized, and offer customization --- for instance, aside from the standard parameters, an arbitrary windowing function can be provided. 

In addition, I also wrote the start of an object-oriented interface for exposing similar functionality as MATLAB. Structured differently from STK, the interface aims to model waves and operations on waves linearly.

Finally, although this isn't as easily representable, I gained a lot of knowledge on how subtractive synthesis works. I feel like my understanding of the topic was strengthened.

# Challenges

I faced several challenges in the realization of this project, some of which I've already mentioned.

Firstly, this project faced a time management issue, though of a different sort to the previous one.
Even though I was able to clearly define and plan the scope of the work I would do, as well as draw up a timeline for when to do it, I wasn't prepared to both need as much time as I did and have as little time as I did.
This issue meant that my schedule got pushed back to the point where when I ran into issues in the second half of the project where I had originally anticipated I would, I no longer had time to work through them like I had hoped.
Instead, I was forced to cut back on the scale and abandon some portions.

Also affecting my time issue, a lot more of my project was interdependent than I anticipated.
This meant that when I hit a roadblock while working, I wasn't able to just switch topics like I originally planned to.

The challenge that affected my project scope the most was, funnily enough, the same issue that roadblocked me in my MUMT 306 project as well.
When writing academic code especially, I often take the opportunity to write code that's not only functional but also optimally structured following language best practices.
All of these factors combined resulted in object-oriented low-level code, one of my originally-planned results of the project, simply not being achievable in the time given. 
However, this specific challenge brought with it a success of sorts --- with this, I finally understood how to vectorize operations properly in MATLAB.

# Reflection

To me, this project first and foremost is a response using many of the lessons I learned from my MUMT 306 project.
That project suffered from a lack of clear planning, resulting in an unclear and therefore undeliverable product.
Although I ended up being able to assemble something, I knew that for this project I wanted to have more defined goals in mind from the start, so that I wouldn't have to figure out what I was aiming for halfway through the project.
This ended up happening and working fairly well!
I was able to define a clearer timeline at the proposal stage, and with planning in mind, was able to structure my project such that there would be clear goals that would be achievable independently.
I was able to draw up a timeline that reflected this as well.
At the same time, this project had its own set of issues, as I detailed in the [Challenges](#Challenges) section.
With everything in mind, though, I think I'm happy with what this project represents. 

Overall, I see this project as a good basis for further experimentation. I'm really hapy with the amount I learned and the depth of understanding I achieved, even if I didn't end up with as much of an implementation as I hoped to show.

# Extension

If I had more time to continue working on this project, I would love to finish my object-oriented implementation of the algorithms that I finished developing in MATLAB.
I started this project partly due to my dislike of the way STK implements its C++ API --- it bothered me that the project wasn't written with modern code styling in mind, so I had to effectively write C with objects.
With more time to think through the layout of the program structure and what to expose as an API, I'm sure that I would be able to create a more satisfying product.

In addition, there are a few other components that I would be able to finish on the MATLAB side.
Chiefly, an easy task to complete would be to conert the output array that my functions generate to an audio file, for another method of data visualization.
However, it would also be possible to harness the power of computing and, in contrast to manually searching for optimal parameter values, experiment with using MATLAB to find optimal values of $\alpha$ and $N_h$.

