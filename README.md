# psychometric_modelling
#### MATLAB procedure to extract behavioural response data and construct psychometric models, to support facial emotion EEG classification [NTU - Jul 2018]

Psychometric (sigmoidal) curves are fitted to identify the Point of Subjective Equality (PSE) where observing subjects' responses are split between the binary classes. Properties of the psychometric curves can reveal individual differences in perceptual thresholds, bias and sensitivity. 

 <img src="https://github.com/manuelseet/psychometric_modelling/blob/main/P80.png" alt="psychometric curve" height = 300/> <img src="https://github.com/manuelseet/psychometric_modelling/blob/main/P3.png" alt="psychometric curve" height = 300/> 

### Binary perceptual decision-making with transient emotional stimuli  
In this study, subjects were briefly (<200ms) presented with cued images of facial expressions, after which they indicated with a console whether they have just perceived a `Happy` or `Angry` face (polar on both valence and arousal). EEG signals were recorded during this process, for neurocognitive modelling and multiclass classification. 

Sigmoid function courtesy of [Assoc. Prof. Ning Qian] (Columbia University)

[Assoc. Prof. Ning Qian]: http://www.columbia.edu/~nq6/
