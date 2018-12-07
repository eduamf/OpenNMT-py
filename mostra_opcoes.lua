require('onmt.init')

local cmd = torch.CmdLine()
cmd:option('-model', '', 'trained model file')
cmd:option('-gpuid', 0, 'gpu id to load gpu model')
local opt = cmd:parse(arg)

if opt.gpuid > 0 then
  require('cutorch')
end
local checkpoint = torch.load(opt.model)
print(checkpoint.options)

