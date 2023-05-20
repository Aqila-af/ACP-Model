param lambdaChurn = 0.1;              /* Churn rate */
param muAcquisition = 0.2;            /* Acquisition rate */
param nuPotentialAcquisition = 0.05;  /* Potential acquisition rate */
param reacquisitionFactor = 0.5;      /* Effectiveness of reacquisition strategies */

param marketingEffectiveness = 0.3;  /* Effectiveness of marketing efforts */
param promotionEffectiveness = 0.2;  /* Effectiveness of promotional campaigns */
param serviceImprovementEffectiveness = 0.1;  /* Effectiveness of service improvements */

const startA = 100;             /* Initial number of active customers */
const startC = 40;              /* Initial number of churned customers */
const startP = 30;              /* Initial number of potential customers */
const startF = 5;               /* Initial number of factors affecting active customers */
const startS = 100;             

species A;
species C;
species P;
species F;     
species S;       /* Customer satisfaction factor */
species G;      /* Reacquired customers */              

rule churn {
  A -[ #A *lambdaChurn * %F * %S ]-> C
}

rule regain {
  C -[ #C * reacquisitionFactor ]-> G
}

rule acquisition {
  G -[ #G * muAcquisition ]-> A
}

rule potentialAcquisition {
  P -[ #P * (nuPotentialAcquisition * marketingEffectiveness * promotionEffectiveness * serviceImprovementEffectiveness) ]-> A
}

rule satisfactionDecay {
    S -[#S * 0.95]-> S;            /* Decay factor of 0.95 per time step */
}
system init = A <startA> | C <startC> | P <startP> | F <startF>; | S <startS>;
