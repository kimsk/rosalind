%%%-------------------------------------------------------------------
%%% @author Bradford Winfrey <bradford.winfrey@gmail.com>
%%% @copyright (C) 2013, Bradford Winfrey
%%% @doc
%%%
%%% @end
%%% Created :  8 Sep 2013 by Bradford Winfrey <bradford.winfrey@gmail.com>
%%%-------------------------------------------------------------------
-module(revc).

-include_lib("eunit/include/eunit.hrl").
%% API
-export([revc/1]).

%%%===================================================================
%%% API
%%%===================================================================
revc([])    -> <<>>;
revc(<<>>)  -> <<>>;
revc(Dataset) when is_list(Dataset) ->
    revc(list_to_binary(Dataset));
revc(Dataset) when is_binary(Dataset) ->
    revc(Dataset, erlang:byte_size(Dataset), <<>>);
revc(_) -> <<>>.

%%--------------------------------------------------------------------
%% @doc
%% @spec
%% @end
%%--------------------------------------------------------------------

%%%===================================================================
%%% Internal functions
%%%===================================================================
revc(<<>>, _, Output) -> Output;
revc(Strand, RemLen, Output) ->
  P = RemLen - 1,
  <<Rest:P/binary,M:1/binary>> = Strand,
  C = comp(M),
  revc(Rest, P, <<Output/binary,C/binary>>).

comp(<<$A>>)  -> <<$T>>;
comp(<<$T>>)  -> <<$A>>;
comp(<<$C>>)  -> <<$G>>;
comp(<<$G>>)  -> <<$C>>;
comp(_)       -> <<>>.

%%%% TEST %%%%

revc_test() ->
    Sample = "AAAACCCGGT",
    ?assertMatch(<<"ACCGGGTTTT">>, revc(Sample)).