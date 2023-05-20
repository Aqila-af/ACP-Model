param lambdaChurn = 0.1;              /* Churn rate */
param dissatisfaction = 0.04;         /* rate of dissatisfaction based on the feedback */
param muAcquisition = 0.2;            /* Acquisition rate */
param nuPotentialAcquisition = 0.05;  /* Potential acquisition rate */
param reacquisitionFactor = 0.5;      /* Effectiveness of reacquisition strategies */

param marketingEffectiveness = 0.3;  /* Effectiveness of marketing efforts */
param promotionEffectiveness = 0.2;  /* Effectiveness of promotional campaigns */
param serviceImprovementEffectiveness = 0.1;  /* Effectiveness of service improvements */

param regainRate = 0.3;               /* Rate of regaining churned customers */

const startA = 100;             /* Initial number of active customers */
const startC = 40;              /* Initial number of churned customers */
const startP = 30;              /* Initial number of potential customers */
const startF = 5;               /* Initial number of factors affecting active customers */
const startG = 0; 

species A;
species C;
species P;
species F; 
species G;                    

rule churn {
  A -[ #A *lambdaChurn ]-> C
}

rule acquisition {
  C -[ #C * muAcquisition * reacquisitionFactor ]-> A
}

rule regain {
  C -[ #C *regainRate ]-> G
}
rule acquisition {
  C|G -[ #C *muAcquisition ]-> A|G
}


rule potentialAcquisition {
  P -[ #P * (nuPotentialAcquisition * marketingEffectiveness * promotionEffectiveness * serviceImprovementEffectiveness) ]-> A
}

system init = A <startA> | C <startC> | P <startP> | F <startF>;
