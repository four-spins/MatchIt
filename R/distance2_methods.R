#distance2glm-----------------
distance2glm <- function(formula, data = NULL, link = "logit", ...) {

  if (!is.null(link) && startsWith(as.character(link), "linear")) {
    linear <- TRUE
    link <- sub("linear.", "", as.character(link), fixed = TRUE)
  }
  else linear <- FALSE

  A <- list(...)
  A[!names(A) %in% c(names(formals(glm)), names(formals(glm.control)))] <- NULL

  res <- do.call("glm", c(list(formula = formula, data = data, family = quasibinomial(link = link)), A))

  if (linear) pred <- predict(res, type = "link")
  else pred <- predict(res, type = "response")

  return(list(model = res, distance = pred))
}

#distance2gam-----------------
distance2gam <- function(formula, data = NULL, link = "logit", ...) {
  check.package("mgcv")

  if (!is.null(link) && startsWith(as.character(link), "linear")) {
    linear <- TRUE
    link <- sub("linear.", "", as.character(link), fixed = TRUE)
  }
  else linear <- FALSE

  A <- list(...)
  weights <- A$weights
  A$weights <- NULL

  res <- do.call(mgcv::gam, c(list(formula, data, family = quasibinomial(link),
                                   weights = weights), A),
                 quote = TRUE)

  if (linear) pred <- predict(res, type = "link")
  else pred <- predict(res, type = "response")

  return(list(model = res, distance = as.numeric(pred)))
}

#distance2rpart-----------------
distance2rpart <- function(formula, data = NULL, link = NULL, ...) {
  check.package("rpart")
  A <- list(...)
  A[!names(A) %in% c(names(formals(rpart::rpart)), names(formals(rpart::rpart.control)))] <- NULL
  A$formula <- formula
  A$data <- data
  A$method <- "class"

  res <- do.call(rpart::rpart, A)
  return(list(model = res, distance = predict(res, type = "prob")[,"1"]))
}

#distance2nnet-----------------
distance2nnet <- function(formula, data = NULL, link = NULL, ...) {
  check.package("nnet")

  A <- list(...)
  weights <- A$weights
  A$weights <- NULL

  res <- do.call(nnet::nnet, c(list(formula, data, weights = weights, entropy = TRUE), A), quote = TRUE)
  return(list(model = res, distance = drop(fitted(res))))
}

#distance2cbps-----------------
distance2cbps <- function(formula, data = NULL, link = NULL, ...) {
  check.package("CBPS")

  if (!is.null(link) && startsWith(as.character(link), "linear")) {
    linear <- TRUE
  }
  else linear <- FALSE

  A <- list(...)

  A[["standardized"]] <- FALSE
  if (is.null(A[["ATT"]])) {
    if (is.null(A[["estimand"]])) A[["ATT"]] <- 1
    else {
      estimand <- toupper(A[["estimand"]])
      estimand <- match_arg(estimand, c("ATT", "ATC", "ATE"))
      A[["ATT"]] <- switch(estimand, "ATT" = 1, "ATC" = 2, 0)
    }
  }
  if (is.null(A[["method"]])) {
    if (is.null(A[["over"]])) A[["method"]] <- "over"
    else {
      A[["method"]] <- if (isFALSE(A[["over"]])) "exact" else "over"
    }
  }
  A[c("estimand", "over")] <- NULL

  if (!is.null(A[["weights"]])) {
    A[["sample.weights"]] <- A[["weights"]]
    A[["weights"]] <- NULL
  }

  capture.output({ #Keeps from printing message about treatment
    res <- do.call(CBPS::CBPS, c(list(formula, data), A), quote = TRUE)
  })

  pred <- fitted(res)
  if (linear) pred <- qlogis(pred)

  return(list(model = res, distance = pred))
}

#distance2bart----------------
distance2bart <- function(formula, data = NULL, link = NULL, ...) {
  check.package("dbarts")

  if (!is.null(link) && startsWith(as.character(link), "linear")) {
    linear <- TRUE
  }
  else linear <- FALSE

  A <- list(...)
  A[!names(A) %in% c(names(formals(dbarts::bart2)), names(formals(dbarts::dbartsControl)))] <- NULL
  A$formula <- formula
  A$data <- data

  res <- do.call(dbarts::bart2, A)

  if (linear) pred <- fitted(res, type = "link")
  else pred <- fitted(res, type = "response")

  return(list(model = res, distance = pred))
}

# distance2bart <- function(formula, data, link = NULL, ...) {
#   check.package("BART")
#
#   if (!is.null(link) && startsWith(as.character(link), "linear")) {
#     linear <- TRUE
#     link <- sub("linear.", "", as.character(link), fixed = TRUE)
#   }
#   else linear <- FALSE
#
#   #Keep link probit because default in matchit is logit but probit is much faster with BART
#   link <- "probit"
#
#   # if (is.null(link)) link <- "probit"
#   # else if (!link %in% c("probit", "logit")) {
#   #   stop("'link' must be \"probit\" or \"logit\" with distance = \"bart\".", call. = FALSE)
#   # }
#
#   data <- model.frame(formula, data)
#
#   treat <- binarize(data[[1]])
#   X <- data[-1]
#
#   chars <- vapply(X, is.character, logical(1L))
#   X[chars] <- lapply(X[chars], factor)
#
#   A <- list(...)
#
#   if (!is.null(A[["mc.cores"]]) && A[["mc.cores"]][1] > 1) fun <- BART::mc.gbart
#   else fun <- BART::gbart
#
#   res <- do.call(fun, c(list(X,
#                              y.train = treat,
#                              type = switch(link, "logit" = "lbart", "pbart")),
#                         A[intersect(names(A), setdiff(names(formals(fun)),
#                                                       c("x.train", "y.train", "x.test", "type", "ntype")))]))
#
#   pred <- res$prob.train.mean
#   if (linear) pred <- switch(link, logit = qlogis, probit = qnorm)(pred)
#
#   return(list(model = res, distance = pred))
# }

#distance2randomforest-----------------
distance2randomforest <- function(formula, data = NULL, link = NULL, ...) {
  check.package("randomForest")
  newdata <- get_all_vars(formula, data)
  treatvar <- as.character(formula[[2]])
  newdata[[treatvar]] <- factor(newdata[[treatvar]], levels = c("0", "1"))
  res <- randomForest::randomForest(formula, data = newdata, ...)
  return(list(model = res, distance = predict(res, type = "prob")[,"1"]))
}

#distance2glmnet--------------
distance2elasticnet <- function(formula, data = NULL, link = NULL, ...) {
  if (!is.null(link) && startsWith(as.character(link), "linear")) {
    linear <- TRUE
    link <- sub("linear.", "", as.character(link), fixed = TRUE)
  }
  else linear <- FALSE

  A <- list(...)
  s <- A[["s"]]
  A[!names(A) %in% c(names(formals(glmnet::glmnet)), names(formals(glmnet::cv.glmnet)))] <- NULL

  if (is.null(link)) link <- "logit"
  if (link == "logit") A$family <- "binomial"
  else if (link == "log") A$family <- "poisson"
  else A$family <- binomial(link = link)

  if (is.null(A[["alpha"]])) A[["alpha"]] <- .5

  mf <- model.frame(formula, data = data)

  A$y <- model.response(mf)
  A$x <- model.matrix(update(formula, . ~ . + 1), mf)[,-1,drop = FALSE]

  res <- do.call(glmnet::cv.glmnet, A)

  if (is.null(s)) s <- "lambda.1se"

  pred <- drop(predict(res, newx = A$x, s = s,
                  type = if (linear) "link" else "response"))

  return(list(model = res, distance = pred))
}
distance2lasso <- function(formula, data = NULL, link = NULL, ...) {
  if (!is.null(link) && startsWith(as.character(link), "linear")) {
    linear <- TRUE
    link <- sub("linear.", "", as.character(link), fixed = TRUE)
  }
  else linear <- FALSE

  A <- list(...)
  s <- A[["s"]]
  A[!names(A) %in% c(names(formals(glmnet::glmnet)), names(formals(glmnet::cv.glmnet)))] <- NULL

  if (is.null(link)) link <- "logit"
  if (link == "logit") A$family <- "binomial"
  else if (link == "log") A$family <- "poisson"
  else A$family <- binomial(link = link)

  A[["alpha"]] <- 1

  mf <- model.frame(formula, data = data)

  A$y <- model.response(mf)
  A$x <- model.matrix(update(formula, . ~ . + 1), mf)[,-1,drop = FALSE]

  res <- do.call(glmnet::cv.glmnet, A)

  if (is.null(s)) s <- "lambda.1se"

  pred <- drop(predict(res, newx = A$x, s = s,
                       type = if (linear) "link" else "response"))

  return(list(model = res, distance = pred))
}
distance2ridge <- function(formula, data = NULL, link = NULL, ...) {
  if (!is.null(link) && startsWith(as.character(link), "linear")) {
    linear <- TRUE
    link <- sub("linear.", "", as.character(link), fixed = TRUE)
  }
  else linear <- FALSE

  A <- list(...)
  s <- A[["s"]]
  A[!names(A) %in% c(names(formals(glmnet::glmnet)), names(formals(glmnet::cv.glmnet)))] <- NULL

  if (is.null(link)) link <- "logit"
  if (link == "logit") A$family <- "binomial"
  else if (link == "log") A$family <- "poisson"
  else A$family <- binomial(link = link)

  A[["alpha"]] <- 0

  mf <- model.frame(formula, data = data)

  A$y <- model.response(mf)
  A$x <- model.matrix(update(formula, . ~ . + 1), mf)[,-1,drop = FALSE]

  res <- do.call(glmnet::cv.glmnet, A)

  if (is.null(s)) s <- "lambda.1se"

  pred <- drop(predict(res, newx = A$x, s = s,
                       type = if (linear) "link" else "response"))

  return(list(model = res, distance = pred))
}

#distance2gbm--------------
distance2gbm <- function(formula, data = NULL, link = NULL, ...) {
  if (!is.null(link) && startsWith(as.character(link), "linear")) {
    linear <- TRUE
  }
  else linear <- FALSE

  A <- list(...)

  method <- A[["method"]]
  A[!names(A) %in% names(formals(gbm::gbm))] <- NULL

  A$formula <- formula
  A$data <- data
  A$distribution <- "bernoulli"

  if (is.null(A[["n.trees"]])) A[["n.trees"]] <- 1e4
  if (is.null(A[["interaction.depth"]])) A[["interaction.depth"]] <- 3
  if (is.null(A[["shrinkage"]])) A[["shrinkage"]] <- .01
  if (is.null(A[["bag.fraction"]])) A[["bag.fraction"]] <- 1
  if (is.null(A[["cv.folds"]])) A[["cv.folds"]] <- 5
  if (is.null(A[["keep.data"]])) A[["keep.data"]] <- FALSE

  if (A[["cv.folds"]] <= 1 && A[["bag.fraction"]] == 1) {
    stop("Either 'bag.fraction' must be less than 1 or 'cv.folds' must be greater than 1 when using distance = \"gbm\".",
         call. = FALSE)
  }
  if (is.null(method)) {
    if (A[["bag.fraction"]] < 1) method <- "OOB"
    else method <- "cv"
  }
  else if (!tolower(method) %in% c("oob", "cv")) {
    stop("distance.options$method should be one of \"OOB\" or \"cv\".", call. = FALSE)
  }

  res <- do.call(gbm::gbm, A)

  best.tree <- gbm::gbm.perf(res, plot.it = FALSE, method = method)

  pred <- drop(predict(res, newdata = data, n.trees = best.tree,
                       type = if (linear) "link" else "response"))

  return(list(model = res, distance = pred))
}