#!/usr/bin/env ruby

file_path = File.expand_path("../day-23-input-part-2.txt", __FILE__)
input     = File.read(file_path)

instructions = input.split("\n")

reg = { "a" => 12 }

i = 0

def argToVal(arg, reg)
  if arg =~ /\d/
    arg.to_i
  else
    reg[arg]
  end
end

while i < instructions.length
  cmd, arg1, arg2, arg3 = instructions[i].split(" ")

  arg1Val = argToVal(arg1, reg)
  arg2Val = argToVal(arg2, reg)

  case cmd
  when 'mul'
    reg[arg3] = arg1Val * arg2Val
  when 'cpy'
    reg[arg2] = arg1Val
  when 'jnz'
    i += arg2Val - 1 if arg1Val != 0
  when 'inc'
    reg[arg1] += 1
  when 'dec'
    reg[arg1] -= 1
  when 'tgl'
    idx = i + reg[arg1]

    if instructions[idx]
      cmd, arg1, arg2 = instructions[idx].split(" ")

      if arg2
        replacement = cmd == "jnz" ? "cpy" : "jnz"
      else
        replacement = cmd == "inc" ? "dec" : "inc"
      end

      instructions[idx][0..2] = replacement
    end
  end

  i += 1
end

puts reg['a']
