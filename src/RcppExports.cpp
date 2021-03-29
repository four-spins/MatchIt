// Generated by using Rcpp::compileAttributes() -> do not edit by hand
// Generator token: 10BE3573-1514-4C36-9D1C-5A225CD40393

#include "../inst/include/MatchIt.h"
#include <Rcpp.h>
#include <string>
#include <set>

using namespace Rcpp;

// nn_matchC
IntegerMatrix nn_matchC(const IntegerVector& treat_, const IntegerVector& ord_, const IntegerVector& ratio, const int& max_rat, const bool& replace, const LogicalVector& discarded, const Nullable<NumericVector>& distance_, const Nullable<IntegerVector>& exact_, const Nullable<double>& caliper_dist_, const Nullable<NumericVector>& caliper_covs_, const Nullable<NumericMatrix>& calcovs_covs_mat_, const Nullable<NumericMatrix>& mah_covs_, const Nullable<NumericMatrix>& mahSigma_inv_, const Nullable<IntegerMatrix>& antiexact_covs_, const bool& disl_prog);
RcppExport SEXP _MatchIt_nn_matchC(SEXP treat_SEXP, SEXP ord_SEXP, SEXP ratioSEXP, SEXP max_ratSEXP, SEXP replaceSEXP, SEXP discardedSEXP, SEXP distance_SEXP, SEXP exact_SEXP, SEXP caliper_dist_SEXP, SEXP caliper_covs_SEXP, SEXP calcovs_covs_mat_SEXP, SEXP mah_covs_SEXP, SEXP mahSigma_inv_SEXP, SEXP antiexact_covs_SEXP, SEXP disl_progSEXP) {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::RNGScope rcpp_rngScope_gen;
    Rcpp::traits::input_parameter< const IntegerVector& >::type treat_(treat_SEXP);
    Rcpp::traits::input_parameter< const IntegerVector& >::type ord_(ord_SEXP);
    Rcpp::traits::input_parameter< const IntegerVector& >::type ratio(ratioSEXP);
    Rcpp::traits::input_parameter< const int& >::type max_rat(max_ratSEXP);
    Rcpp::traits::input_parameter< const bool& >::type replace(replaceSEXP);
    Rcpp::traits::input_parameter< const LogicalVector& >::type discarded(discardedSEXP);
    Rcpp::traits::input_parameter< const Nullable<NumericVector>& >::type distance_(distance_SEXP);
    Rcpp::traits::input_parameter< const Nullable<IntegerVector>& >::type exact_(exact_SEXP);
    Rcpp::traits::input_parameter< const Nullable<double>& >::type caliper_dist_(caliper_dist_SEXP);
    Rcpp::traits::input_parameter< const Nullable<NumericVector>& >::type caliper_covs_(caliper_covs_SEXP);
    Rcpp::traits::input_parameter< const Nullable<NumericMatrix>& >::type calcovs_covs_mat_(calcovs_covs_mat_SEXP);
    Rcpp::traits::input_parameter< const Nullable<NumericMatrix>& >::type mah_covs_(mah_covs_SEXP);
    Rcpp::traits::input_parameter< const Nullable<NumericMatrix>& >::type mahSigma_inv_(mahSigma_inv_SEXP);
    Rcpp::traits::input_parameter< const Nullable<IntegerMatrix>& >::type antiexact_covs_(antiexact_covs_SEXP);
    Rcpp::traits::input_parameter< const bool& >::type disl_prog(disl_progSEXP);
    rcpp_result_gen = Rcpp::wrap(nn_matchC(treat_, ord_, ratio, max_rat, replace, discarded, distance_, exact_, caliper_dist_, caliper_covs_, calcovs_covs_mat_, mah_covs_, mahSigma_inv_, antiexact_covs_, disl_prog));
    return rcpp_result_gen;
END_RCPP
}
// pairdistsubC
double pairdistsubC(const NumericVector& x_, const IntegerVector& t_, const IntegerVector& s_, const int& num_sub);
RcppExport SEXP _MatchIt_pairdistsubC(SEXP x_SEXP, SEXP t_SEXP, SEXP s_SEXP, SEXP num_subSEXP) {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::RNGScope rcpp_rngScope_gen;
    Rcpp::traits::input_parameter< const NumericVector& >::type x_(x_SEXP);
    Rcpp::traits::input_parameter< const IntegerVector& >::type t_(t_SEXP);
    Rcpp::traits::input_parameter< const IntegerVector& >::type s_(s_SEXP);
    Rcpp::traits::input_parameter< const int& >::type num_sub(num_subSEXP);
    rcpp_result_gen = Rcpp::wrap(pairdistsubC(x_, t_, s_, num_sub));
    return rcpp_result_gen;
END_RCPP
}
// subclass2mmC
IntegerMatrix subclass2mmC(const IntegerVector& subclass, const IntegerVector& treat, const int& focal);
RcppExport SEXP _MatchIt_subclass2mmC(SEXP subclassSEXP, SEXP treatSEXP, SEXP focalSEXP) {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::RNGScope rcpp_rngScope_gen;
    Rcpp::traits::input_parameter< const IntegerVector& >::type subclass(subclassSEXP);
    Rcpp::traits::input_parameter< const IntegerVector& >::type treat(treatSEXP);
    Rcpp::traits::input_parameter< const int& >::type focal(focalSEXP);
    rcpp_result_gen = Rcpp::wrap(subclass2mmC(subclass, treat, focal));
    return rcpp_result_gen;
END_RCPP
}
// tabulateC
IntegerVector tabulateC(const IntegerVector& bins, const Nullable<int>& nbins);
RcppExport SEXP _MatchIt_tabulateC(SEXP binsSEXP, SEXP nbinsSEXP) {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::RNGScope rcpp_rngScope_gen;
    Rcpp::traits::input_parameter< const IntegerVector& >::type bins(binsSEXP);
    Rcpp::traits::input_parameter< const Nullable<int>& >::type nbins(nbinsSEXP);
    rcpp_result_gen = Rcpp::wrap(tabulateC(bins, nbins));
    return rcpp_result_gen;
END_RCPP
}
// weights_matrixC
NumericVector weights_matrixC(const IntegerMatrix& mm, const IntegerVector& treat);
RcppExport SEXP _MatchIt_weights_matrixC(SEXP mmSEXP, SEXP treatSEXP) {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::RNGScope rcpp_rngScope_gen;
    Rcpp::traits::input_parameter< const IntegerMatrix& >::type mm(mmSEXP);
    Rcpp::traits::input_parameter< const IntegerVector& >::type treat(treatSEXP);
    rcpp_result_gen = Rcpp::wrap(weights_matrixC(mm, treat));
    return rcpp_result_gen;
END_RCPP
}

// validate (ensure exported C++ functions exist before calling them)
static int _MatchIt_RcppExport_validate(const char* sig) { 
    static std::set<std::string> signatures;
    if (signatures.empty()) {
    }
    return signatures.find(sig) != signatures.end();
}

// registerCCallable (register entry points for exported C++ functions)
RcppExport SEXP _MatchIt_RcppExport_registerCCallable() { 
    R_RegisterCCallable("MatchIt", "_MatchIt_RcppExport_validate", (DL_FUNC)_MatchIt_RcppExport_validate);
    return R_NilValue;
}

static const R_CallMethodDef CallEntries[] = {
    {"_MatchIt_nn_matchC", (DL_FUNC) &_MatchIt_nn_matchC, 15},
    {"_MatchIt_pairdistsubC", (DL_FUNC) &_MatchIt_pairdistsubC, 4},
    {"_MatchIt_subclass2mmC", (DL_FUNC) &_MatchIt_subclass2mmC, 3},
    {"_MatchIt_tabulateC", (DL_FUNC) &_MatchIt_tabulateC, 2},
    {"_MatchIt_weights_matrixC", (DL_FUNC) &_MatchIt_weights_matrixC, 2},
    {"_MatchIt_RcppExport_registerCCallable", (DL_FUNC) &_MatchIt_RcppExport_registerCCallable, 0},
    {NULL, NULL, 0}
};

RcppExport void R_init_MatchIt(DllInfo *dll) {
    R_registerRoutines(dll, NULL, CallEntries, NULL, NULL);
    R_useDynamicSymbols(dll, FALSE);
}
