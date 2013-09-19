%%%-------------------------------------------------------------------
%%% @author Bradford Winfrey <brad@bradfordw.local>
%%% @copyright (C) 2013, Bradford Winfrey
%%% @doc
%%%
%%% @end
%%% Created : 13 Sep 2013 by Bradford Winfrey <brad@bradfordw.local>
%%%-------------------------------------------------------------------
-module(hamm).

%% API
-export([hamm/1]).
-include_lib("eunit/include/eunit.hrl").

%%%===================================================================
%%% API
%%%===================================================================
hamm(Data) when is_list(Data) ->
    hamm(list_to_binary(Data));
hamm(Data) when is_binary(Data) ->
    SourceLen = byte_size(Data) - 1,
    <<Data1:SourceLen/binary,_/binary>> = Data,
    DataLen = round((byte_size(Data1) - 1) / 2),
    <<Strand1:DataLen/binary, $\n, Rest/binary>> = Data1,
    hamm(Strand1, Rest, 0).

%%--------------------------------------------------------------------
%% @doc
%% @spec
%% @end
%%--------------------------------------------------------------------
hamm(<<>>,<<>>, Acc) ->
    Acc;
hamm(<<A:1/binary, RestA/binary>>, <<B:1/binary, RestB/binary>>, Acc) when A =:= B->
    hamm(RestA, RestB, Acc);
hamm(<<_:1/binary,RestA/binary>>, <<_:1/binary, RestB/binary>>, Acc) ->
    hamm(RestA, RestB, Acc + 1).

%%%===================================================================
%%% Internal functions
%%%===================================================================

hamm_test() ->
    Data = <<"GAGCCTACTAACGGGAT\nCATCGTAATGACGGCCT">>,
    ?assertEqual(7, hamm(Data)).
