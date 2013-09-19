%%%-------------------------------------------------------------------
%%% @author Bradford Winfrey <bradford.winfrey@gmail.com>
%%% @copyright (C) 2013, Bradford Winfrey
%%% @doc
%%%
%%% A sequence is an ordered collection of objects (usually numbers), which are allowed to repeat. Sequences can be finite or infinite.
%%% Two examples are the finite sequence (π,−2‾√,0,π) and the infinite sequence of odd numbers (1,3,5,7,9,…). We use the notation an to represent the n-th term of a sequence.
%%%
%%% A recurrence relation is a way of defining the terms of a sequence with respect to the values of previous terms.
%%% In the case of Fibonacci's rabbits from the introduction, any given month will contain the rabbits that were alive the previous month, plus any new offspring.
%%%   A key observation is that the number of offspring in any month is equal to the number of rabbits that were alive two months prior.
%%%   As a result, if Fn represents the number of rabbit pairs alive after the n-th month, then we obtain the Fibonacci sequence having terms Fn that are defined
%%%     by the recurrence relation Fn=Fn−1+Fn−2 (with F1=F2=1 to initiate the sequence).
%%%
%%% When finding the n-th term of a sequence defined by a recurrence relation, we can simply use the recurrence relation to generate terms for progressively larger values of n.
%%% This problem introduces us to the computational technique of dynamic programming, which successively builds up solutions by using the answers to smaller cases.
%%%
%%% Given: Positive integers n≤40 and k≤5.
%%%
%%% Return: The total number of rabbit pairs that will be present after n months if we begin with 1 pair and in each generation, every pair of reproduction-age rabbits
%%%   produces a litter of k rabbit pairs (instead of only 1 pair).
%%% @end
%%% Created :  8 Sep 2013 by Bradford Winfrey <bradford.winfrey@gmail.com>
%%%-------------------------------------------------------------------
-module(fib).

-include_lib("eunit/include/eunit.hrl").
%% API
-export([fib/2]).

%%%===================================================================
%%% API
%%%===================================================================
fib(N, K) ->
  fib(N, K, 0, 1).
%%--------------------------------------------------------------------
%% @doc
%% @spec
%% @end
%%--------------------------------------------------------------------

%%%===================================================================
%%% Internal functions
%%%===================================================================
fib(1, _, LG, NG) -> LG + NG;
fib(N, K, LG, NG) ->
  fib(N-1, K, LG + NG, LG * K).

%%%% TEST %%%%
fib_single_test() ->
  ?assertMatch(1, fib(1,3)).

fib_double_test() ->
  ?assertMatch(1, fib(2,3)).

fib_test() ->
  ?assertMatch(19, fib(5, 3)).
