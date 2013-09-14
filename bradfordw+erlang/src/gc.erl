%%%-------------------------------------------------------------------
%%% @author Bradford Winfrey <bradford.winfrey@gmail.com>
%%% @copyright (C) 2013, Bradford Winfrey
%%% @doc
%%%
%%% @end
%%% Created : 10 Sep 2013 by Bradford Winfrey <bradford.winfrey@gmail.com>
%%%-------------------------------------------------------------------
-module(gc).

%% API
-export([gc/1]).
-include_lib("eunit/include/eunit.hrl").
%%%===================================================================
gc([]) -> [];
gc(<<>>) -> <<>>;
gc(Data) when is_list(Data) ->
    gc(list_to_binary(Data));
gc(Data) when is_binary(Data) ->
    gc(Data, {{0, <<>>, 0},{<<>>,0.0}});
gc(_) ->
    {error, invalid_format}.

%%--------------------------------------------------------------------
%% @doc
%% @spec
%% @end
%%--------------------------------------------------------------------
gc(<<>>, State) ->
    {_, {Label, ContentPct}} = higher_gc(State),
    Pct = format_pct(ContentPct),
    <<Label/binary,$\s,Pct/binary>>;
gc(<<$\>,Label:8/binary,$\_,Id:4/binary,Rest/binary>>, State) ->
    {_, Highest} = higher_gc(State),
    gc(<<Rest/binary>>, {{0,<<Label/binary,$_,Id/binary>>, 0}, Highest});
gc(<<$\n,Rest/binary>>, State) ->
    gc(Rest, State);
gc(<<M:1/binary,Rest/binary>>, {Sample, Highest}) ->
    gc(Rest, {incr_gc(M, Sample), Highest}).

incr_gc(M, {Total, Sample, Content}) when M =:= <<$C>> orelse  M =:= <<$G>> ->
    {Total + 1, Sample, Content + 1};
incr_gc(_, {Total, Sample, Content}) ->
    {Total + 1, Sample, Content}.

higher_gc({{0, <<>>, 0}, {<<>>, 0.0}} = State) ->
    State;
higher_gc({{Total, Sample, Content}, {<<>>, 0.0}}) ->
    CurrentPct = (Content / Total) * 100,
    {{0, <<>>, 0}, {Sample, CurrentPct}};
higher_gc({{Total, Sample, Content} = Current, {_Leader, ContentPct} = Highest}) ->
    CurrentPct = (Content / Total) * 100,
    case CurrentPct > ContentPct of
        true ->
            {{Total,Sample,Content}, {Sample, CurrentPct}};
        false ->
            {Current, Highest}
    end.

format_pct(P) ->
    list_to_binary(hd(io_lib:format("~.6f", [P])) ++ "%").

%%%===================================================================
%%% Internal functions
%%%===================================================================
gc_test() ->
    Data = <<">Rosalind_6404\nCCTGCGGAAGATCGGCACTAGAATAGCCAGAACCGTTTCTCTGAGGCTTCCGGCCTTCCCTCCCACTAATAATTCTGAGG\nCCTGCGGAAGATCGGCACTAGAATAGCCAGAACCGTTTCTCTGAGGCTTCCGGCCTTCCCTCCCACTAATAATTCTGAGG\nGCGCTAGCGC\n>Rosalind_5959\nCCATCGGTAGCGCATCCTTAGTCCAATTAAGTCCCTATCCAGGCGCTCCGCCGAAGGTCTATATCCATTTGTCAGCAGACACGC\n>Rosalind_0808\nCCACCCTCGTGGTATGGCTAGGCATTCAGGAACCGGAGAACGCTTCAGACCAGCCCGGACTGGGAACCTGCGGGCAGTAGGTGGAAT\n">>,
    ?assertMatch(<<"Rosalind_0808\s60.919540%">>, gc(Data)).

gc_hundo_test() ->
    Data = <<">Rosalind_0000\nAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\n>Rosalind_1337\nCCCGCGCGCGCGCGCGCGCGCGCGCGCGCGCGCGCGCGCGCGCGCGCGCGCGCGCGCGCGCGCGCGCGCGCGCGCGCGCG\nCGCGCGCGCGCGCGCGCGCGCGCGCGCGCGCGCGCGCGCGCGCGCGCGCGCGCGCGCGCGCGCGCGCGCGCGCGCGCGCG\nGGGGGGGGGC\n">>,
    ?assertMatch(<<"Rosalind_1337\s100.000000%">>, gc(Data)).

higher_gc_test() ->
    State = {{2,<<"Rosalind_1111">>,1},{<<"Rosalind_0000">>,0.0}},
    {_, {<<"Rosalind_1111">>, 50.000000}} = higher_gc(State).

