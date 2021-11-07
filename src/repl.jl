using REPL: REPL, LineEdit

using REPL
using Unitful: s
using FileIO: load, save, loadstreaming, savestreaming
import LibSndFile
using PortAudio
using SampledSignals
using EllipsisNotation

const START_TIME = Ref{Int}(1)

function get_song()
    return load(joinpath(pkgdir(MinionsREPL), "minions.ogg"))
end

const MINIONS_SONG = get_song()

function press(step = 40_000)
    stream = PortAudioStream(0, 2)
    start = START_TIME[]
    try
        if start+step > 1357248
            START_TIME[] = stop = mod1(start+step, 1357248)
            write(stream, MINIONS_SONG[start:end, :])
            write(stream, MINIONS_SONG[1:stop, :])
        else
            START_TIME[] += step
            write(stream, MINIONS_SONG[start:start+step, :])
        end 
    finally
        close(stream)
    end
end


function REPL.LineEdit.match_input(k::Dict{Char}, s::Union{Nothing,LineEdit.MIState}, term::Union{LineEdit.AbstractTerminal,IOBuffer}=LineEdit.terminal(s), cs::Vector{Char}=Char[], keymap::Dict{Char} = k)
    # if we run out of characters to match before resolving an action,
    # return an empty keymap function
    eof(term) && return (s, p) -> :abort
    c = read(term, Char)
    press()
    # Ignore any `wildcard` as this is used as a
    # placeholder for the wildcard (see normalize_key("*"))
    c == LineEdit.wildcard && return (s, p) -> :ok
    push!(cs, c)
    key = haskey(k, c) ? c : LineEdit.wildcard

    # if we don't match on the key, look for a default action then fallback on 'nothing' to ignore
    return LineEdit.match_input(get(k, key, nothing), s, term, cs, keymap)
end
