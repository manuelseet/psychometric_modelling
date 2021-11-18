# psychometric_modelling
#### MATLAB procedure to extract behavioural response data and construct psychometric models

These models supported classification of facial expression using EEG event-related potentials (ERPs) [(Sou, Seet & Xu, 2019)].

Psychometric (sigmoidal) curves were fitted onto binary choice data across 7 graded conditions, following:
y = 1/(1+exp(-k*(x-x0))), where k is the slope parameter and x0 is the threshold/location. 

These curves allow researchers to identify the Point of Subjective Equality (PSE = x0) where observing subjects' responses were split between the classes. Properties of the psychometric curves can reveal individual differences in perceptual thresholds, bias and sensitivity that may have clinical significance. 

 <img src="https://github.com/manuelseet/psychometric_modelling/blob/main/P80.png" alt="psychometric curve" height = 300/> <img src="https://github.com/manuelseet/psychometric_modelling/blob/main/P3.png" alt="psychometric curve" height = 300/> 

### Binary perceptual decision-making with transient emotional stimuli  
In this study, subjects were briefly (<200ms) presented with cued images of facial expressions, after which they indicated with a console whether they have just perceived a `Happy` or `Angry` face (polar on both valence and arousal). EEG signals were recorded during this process, for neurocognitive modelling and multiclass classification. 

## References

Sou, K.L., Seet, M.S. & Xu, H. (2019). Activation Pattern Classification Revealed Facial Expressions Encoding in N170 and P200. The 15th Asia-Pacific Conference on Vision (APCV). https://www.ncbi.nlm.nih.gov/pmc/articles/PMC6794663/#__sec638title

[(Sou, Seet & Xu, 2019)]: https://www.ncbi.nlm.nih.gov/pmc/articles/PMC6794663/#__sec638title
