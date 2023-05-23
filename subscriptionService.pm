/*------------------------ Customer Acquisition and Churn Dynamics ------------------------*/


/* _-_-_-_-_-_-_-_-_-_-_ Params _-_-_-_-_-_-_-_-_-_-_ */


/* Total number of customers at the beginning of the analysis */
param initial_customers = 1000;

/* Average monthly customer acquisition rate */
param acquisition_rate = 50;

/* Average monthly customer churn rate */
param churn_rate = 30;

/* Average monthly customer satisfaction rate (between 0 and 1) */
param satisfaction_rate = 0.8;

/* _-_-_-_-_-_-_-_-_-_-_ Species _-_-_-_-_-_-_-_-_-_-_ */

species A;   /* Active customers */
species C;    /* Churned customers */
species P;     /* Potential customers */
species S;       /* Customer satisfaction */


/* _-_-_-_-_-_-_-_-_-_-_ Consts _-_-_-_-_-_-_-_-_-_-_ */

const l = 1000;       /* Number of max potential customers */
const n = 100;       /* Number of max active customers */   


param marketingCampigns = 0.7;
param promotion = 0.4;

param serviceQuality = 0.8;
param lackOfValue = 0.3;
param competition = 0.8;



rule CustomerAcquisition for i in [1, l]{

        P[i] -[ #P * (marketingCampigns * promotion *acquisition_rate) ]-> A[i]|P[l-1]

}

rule CustomerChurn for i in [1, n]{

        A[i] -[ #A * (serviceQuality * lackOfValue * competition * churn_rate * (1 - satisfaction_rate) ) ]-> C[i]|A[n-1]

}

rule CustomerSatisfaction for i in [1, n]{

        S|A[i] -[ #S *%A * (serviceQuality * satisfaction_rate) ]-> S[i]|A[i]

}


/* _-_-_-_-_-_-_-_-_-_-_ Measures _-_-_-_-_-_-_-_-_-_-_ */


/* Total number of customers over time */
measure total_customers = initial_customers + #acquired_customers - #churned_customers;

/* Number of acquired customers */
measure acquired_customers = acquisition_rate * time;

/* Number of churned customers */
measure churned_customers = churn_rate * time;

/* Customer satisfaction */
measure satisfaction = satisfaction_rate * time;


system init = A<1000> C<30> P<100> S<60>;