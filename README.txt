<<<<<<< HEAD
Issues : 
- feedforward is too slow compared to the simulation, it makes about 1 step when PD make 10
    => u_ff is some kind of an offset and u_pd controls
- omega value doesn't change theta behavior
=======
Started to implement Neuron Oscillator in eqns
It compiles but the NO does wtf
- eqns is the "main" file of NO 
- what y(i) corresponds to what is explicitely shown in the eqns
- I've taken the equations found on the internet code, so interaction between NO isn't implemented yet
- I suppose that input gain comes only from q(1) for stance, q(2) for swing
- I suppose that the output of the NO is u. Another option would be that output of NO is y_desired and you give the PD controller y_desired-y_real, and PD gives u
- n0 values are taken from the internet code, more or less
- there are 11 parameters + 14 initial values and 14 differential equations to optimize, I wouldn't be surprised if optimization needs a loooooot of iterations to be a bit useful
- how about including NO to the impact map, i.e swing NO always controls swing leg ?
>>>>>>> 2574cc219d2bf92bdf662e77ce6f832ac9afb56d
