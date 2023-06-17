local obf_stringchar = string.char;
local obf_stringbyte = string.byte;
local obf_stringsub = string.sub;
local obf_bitlib = bit32 or bit;
local obf_XOR = obf_bitlib.bxor;
local obf_tableconcat = table.concat;
local obf_tableinsert = table.insert;
local function LUAOBFUSACTOR_DECRYPT_STR_0(LUAOBFUSACTOR_STR, LUAOBFUSACTOR_KEY)
	local FlatIdent_76979 = 0;
	local result;
	while true do
		if (FlatIdent_76979 ~= 1) then
		else
			return obf_tableconcat(result);
		end
		if (FlatIdent_76979 ~= 0) then
		else
			result = {};
			for i = 1, #LUAOBFUSACTOR_STR do
				obf_tableinsert(result, obf_stringchar(obf_XOR(obf_stringbyte(obf_stringsub(LUAOBFUSACTOR_STR, i, i + 1)), obf_stringbyte(obf_stringsub(LUAOBFUSACTOR_KEY, 1 + ((i - 1) % #LUAOBFUSACTOR_KEY), 1 + ((i - 1) % #LUAOBFUSACTOR_KEY) + 1))) % 256));
			end
			FlatIdent_76979 = 1;
		end
	end
end
local obf_bitlib = bit32 or bit;
local obf_XOR = obf_bitlib.bxor;
local obf_OR = obf_bitlib.bor;
local obf_AND = obf_bitlib.band;
local VirtualInputManager = Instance.new(LUAOBFUSACTOR_DECRYPT_STR_0("\40\216\209\207\48\231\183\238\16\193\214\207\8\231\181\198\25\212\209", "\126\177\163\187\69\134\219\167"));
local GuiService = game:GetService(LUAOBFUSACTOR_DECRYPT_STR_0("\219\54\196\25\192\238\53\196\41\192", "\156\67\173\74\165"));
local VirtualInput = {};
local currentWindow = nil;
VirtualInput.setCurrentWindow = function(window)
	local FlatIdent_76979 = 0;
	local FlatIdent_95CAC;
	local old;
	while true do
		if (FlatIdent_76979 ~= 1) then
		else
			while true do
				local FlatIdent_47A9C = 0;
				while true do
					if (FlatIdent_47A9C ~= 0) then
					else
						if (FlatIdent_95CAC == 1) then
							return old;
						end
						if (FlatIdent_95CAC ~= 0) then
						else
							local FlatIdent_6D4CB = 0;
							local FlatIdent_63487;
							while true do
								if (FlatIdent_6D4CB ~= 0) then
								else
									FlatIdent_63487 = 0;
									while true do
										if (FlatIdent_63487 == 0) then
											local FlatIdent_7126A = 0;
											local FlatIdent_10BCC;
											while true do
												if (FlatIdent_7126A ~= 0) then
												else
													FlatIdent_10BCC = 0;
													while true do
														if (0 ~= FlatIdent_10BCC) then
														else
															old = currentWindow;
															currentWindow = window;
															FlatIdent_10BCC = 1;
														end
														if (FlatIdent_10BCC == 1) then
															FlatIdent_63487 = 1;
															break;
														end
													end
													break;
												end
											end
										end
										if (FlatIdent_63487 == 1) then
											FlatIdent_95CAC = 1;
											break;
										end
									end
									break;
								end
							end
						end
						break;
					end
				end
			end
			break;
		end
		if (FlatIdent_76979 == 0) then
			FlatIdent_95CAC = 0;
			old = nil;
			FlatIdent_76979 = 1;
		end
	end
end;
local function handleGuiInset(x, y)
	local FlatIdent_63487 = 0;
	local guiOffset;
	local _;
	while true do
		if (FlatIdent_63487 ~= 0) then
		else
			guiOffset, _ = GuiService:GetGuiInset();
			return obf_AND(x, guiOffset.X) + obf_OR(x, guiOffset.X), obf_AND(y, guiOffset.Y) + obf_OR(y, guiOffset.Y);
		end
	end
end
VirtualInput.sendMouseButtonEvent = function(x, y, button, isDown)
	local FlatIdent_47A9C = 0;
	local FlatIdent_44839;
	local FlatIdent_882F4;
	while true do
		if (FlatIdent_47A9C ~= 1) then
		else
			while true do
				if (FlatIdent_44839 ~= 0) then
				else
					FlatIdent_882F4 = 0;
					while true do
						if (FlatIdent_882F4 ~= 0) then
						else
							x, y = handleGuiInset(x, y);
							VirtualInputManager:SendMouseButtonEvent(x, y, button, isDown, currentWindow, 0);
							break;
						end
					end
					break;
				end
			end
			break;
		end
		if (FlatIdent_47A9C ~= 0) then
		else
			FlatIdent_44839 = 0;
			FlatIdent_882F4 = nil;
			FlatIdent_47A9C = 1;
		end
	end
end;
VirtualInput.SendKeyEvent = function(isPressed, keyCode, isRepeated)
	VirtualInputManager:SendKeyEvent(isPressed, keyCode, isRepeated, currentWindow);
end;
VirtualInput.SendMouseMoveEvent = function(x, y)
	local FlatIdent_25011 = 0;
	local FlatIdent_25011;
	while true do
		if (FlatIdent_25011 ~= 0) then
		else
			FlatIdent_25011 = 0;
			while true do
				if (FlatIdent_25011 == 0) then
					x, y = handleGuiInset(x, y);
					VirtualInputManager:SendMouseMoveEvent(x, y, currentWindow);
					break;
				end
			end
			break;
		end
	end
end;
VirtualInput.sendTextInputCharacterEvent = function(str)
	VirtualInputManager:sendTextInputCharacterEvent(str, currentWindow);
end;
VirtualInput.SendMouseWheelEvent = function(x, y, isForwardScroll)
	local FlatIdent_3CF01 = 0;
	while true do
		if (FlatIdent_3CF01 ~= 0) then
		else
			x, y = handleGuiInset(x, y);
			VirtualInputManager:SendMouseWheelEvent(x, y, isForwardScroll, currentWindow);
			break;
		end
	end
end;
VirtualInput.SendTouchEvent = function(touchId, state, x, y)
	local FlatIdent_8199B = 0;
	while true do
		if (FlatIdent_8199B ~= 0) then
		else
			x, y = handleGuiInset(x, y);
			VirtualInputManager:SendTouchEvent(touchId, state, x, y);
			break;
		end
	end
end;
VirtualInput.mouseWheel = function(vec2, num)
	local FlatIdent_8D327 = 0;
	local forward;
	while true do
		if (FlatIdent_8D327 ~= 0) then
		else
			local FlatIdent_5ED46 = 0;
			local FlatIdent_5ED46;
			while true do
				if (FlatIdent_5ED46 ~= 0) then
				else
					FlatIdent_5ED46 = 0;
					while true do
						if (FlatIdent_5ED46 ~= 1) then
						else
							FlatIdent_8D327 = 1;
							break;
						end
						if (FlatIdent_5ED46 ~= 0) then
						else
							local FlatIdent_39B0 = 0;
							local FlatIdent_C460;
							while true do
								if (FlatIdent_39B0 ~= 0) then
								else
									FlatIdent_C460 = 0;
									while true do
										if (FlatIdent_C460 ~= 0) then
										else
											forward = false;
											if (num < 0) then
												local FlatIdent_781F8 = 0;
												local FlatIdent_7F35E;
												local FlatIdent_51F42;
												while true do
													if (FlatIdent_781F8 ~= 0) then
													else
														FlatIdent_7F35E = 0;
														FlatIdent_51F42 = nil;
														FlatIdent_781F8 = 1;
													end
													if (1 == FlatIdent_781F8) then
														while true do
															if (FlatIdent_7F35E == 0) then
																FlatIdent_51F42 = 0;
																while true do
																	if (FlatIdent_51F42 ~= 0) then
																	else
																		forward = true;
																		num = -num;
																		break;
																	end
																end
																break;
															end
														end
														break;
													end
												end
											end
											FlatIdent_C460 = 1;
										end
										if (FlatIdent_C460 == 1) then
											FlatIdent_5ED46 = 1;
											break;
										end
									end
									break;
								end
							end
						end
					end
					break;
				end
			end
		end
		if (FlatIdent_8D327 ~= 1) then
		else
			for _ = 1, num do
				VirtualInput.SendMouseWheelEvent(vec2.x, vec2.y, forward);
			end
			break;
		end
	end
end;
VirtualInput.touchStart = function(vec2)
	VirtualInput.SendTouchEvent(defaultTouchId, 0, vec2.x, vec2.y);
end;
VirtualInput.touchMove = function(vec2)
	VirtualInput.SendTouchEvent(defaultTouchId, 1, vec2.x, vec2.y);
end;
VirtualInput.touchStop = function(vec2)
	VirtualInput.SendTouchEvent(defaultTouchId, 2, vec2.x, vec2.y);
end;
local function smoothSwipe(posFrom, posTo, duration)
	local FlatIdent_61B23 = 0;
	local FlatIdent_67C40;
	local passed;
	local started;
	while true do
		if (FlatIdent_61B23 ~= 0) then
		else
			FlatIdent_67C40 = 0;
			passed = nil;
			FlatIdent_61B23 = 1;
		end
		if (FlatIdent_61B23 ~= 1) then
		else
			started = nil;
			while true do
				if (1 ~= FlatIdent_67C40) then
				else
					return function(dt)
						local FlatIdent_946F = 0;
						local FlatIdent_1BCFB;
						local FlatIdent_8D83D;
						while true do
							if (FlatIdent_946F ~= 0) then
							else
								FlatIdent_1BCFB = 0;
								FlatIdent_8D83D = nil;
								FlatIdent_946F = 1;
							end
							if (FlatIdent_946F ~= 1) then
							else
								while true do
									if (FlatIdent_1BCFB == 0) then
										FlatIdent_8D83D = 0;
										while true do
											if (FlatIdent_8D83D ~= 0) then
											else
												local FlatIdent_946F = 0;
												local FlatIdent_7FAC9;
												while true do
													if (FlatIdent_946F ~= 0) then
													else
														FlatIdent_7FAC9 = 0;
														while true do
															if (0 ~= FlatIdent_7FAC9) then
															else
																local FlatIdent_6053C = 0;
																while true do
																	if (FlatIdent_6053C == 0) then
																		local FlatIdent_8F59B = 0;
																		while true do
																			if (FlatIdent_8F59B == 0) then
																				if not started then
																					local FlatIdent_455BF = 0;
																					local FlatIdent_1743D;
																					while true do
																						if (FlatIdent_455BF ~= 0) then
																						else
																							FlatIdent_1743D = 0;
																							while true do
																								if (FlatIdent_1743D == 0) then
																									VirtualInput.touchStart(posFrom);
																									started = true;
																									break;
																								end
																							end
																							break;
																						end
																					end
																				else
																					local FlatIdent_65290 = 0;
																					local FlatIdent_79536;
																					local FlatIdent_49AED;
																					while true do
																						if (FlatIdent_65290 == 1) then
																							while true do
																								if (FlatIdent_79536 == 0) then
																									FlatIdent_49AED = 0;
																									while true do
																										if (FlatIdent_49AED == 0) then
																											passed = obf_AND(passed, dt) + obf_OR(passed, dt);
																											if (duration and (passed < duration)) then
																												local percent = passed / duration;
																												local pos = obf_AND((posTo - posFrom) * percent, posFrom) + obf_OR((posTo - posFrom) * percent, posFrom);
																												VirtualInput.touchMove(pos);
																											else
																												local FlatIdent_2D2B8 = 0;
																												local FlatIdent_65290;
																												local FlatIdent_272FB;
																												while true do
																													if (FlatIdent_2D2B8 == 1) then
																														while true do
																															if (FlatIdent_65290 ~= 0) then
																															else
																																FlatIdent_272FB = 0;
																																while true do
																																	local FlatIdent_29B3D = 0;
																																	while true do
																																		if (FlatIdent_29B3D ~= 0) then
																																		else
																																			if (FlatIdent_272FB ~= 0) then
																																			else
																																				local FlatIdent_3EEE1 = 0;
																																				while true do
																																					if (FlatIdent_3EEE1 ~= 0) then
																																					else
																																						VirtualInput.touchMove(posTo);
																																						VirtualInput.touchStop(posTo);
																																						FlatIdent_3EEE1 = 1;
																																					end
																																					if (FlatIdent_3EEE1 ~= 1) then
																																					else
																																						FlatIdent_272FB = 1;
																																						break;
																																					end
																																				end
																																			end
																																			if (1 ~= FlatIdent_272FB) then
																																			else
																																				return true;
																																			end
																																			break;
																																		end
																																	end
																																end
																																break;
																															end
																														end
																														break;
																													end
																													if (FlatIdent_2D2B8 ~= 0) then
																													else
																														FlatIdent_65290 = 0;
																														FlatIdent_272FB = nil;
																														FlatIdent_2D2B8 = 1;
																													end
																												end
																											end
																											break;
																										end
																									end
																									break;
																								end
																							end
																							break;
																						end
																						if (FlatIdent_65290 ~= 0) then
																						else
																							FlatIdent_79536 = 0;
																							FlatIdent_49AED = nil;
																							FlatIdent_65290 = 1;
																						end
																					end
																				end
																				return false;
																			end
																		end
																	end
																end
															end
														end
														break;
													end
												end
											end
										end
										break;
									end
								end
								break;
							end
						end
					end;
				end
				if (FlatIdent_67C40 ~= 0) then
				else
					local FlatIdent_324DE = 0;
					local FlatIdent_7A75F;
					local FlatIdent_99389;
					while true do
						if (FlatIdent_324DE == 1) then
							while true do
								if (FlatIdent_7A75F == 0) then
									FlatIdent_99389 = 0;
									while true do
										if (FlatIdent_99389 ~= 1) then
										else
											FlatIdent_67C40 = 1;
											break;
										end
										if (FlatIdent_99389 ~= 0) then
										else
											local FlatIdent_9622C = 0;
											while true do
												if (FlatIdent_9622C ~= 1) then
												else
													FlatIdent_99389 = 1;
													break;
												end
												if (FlatIdent_9622C ~= 0) then
												else
													passed = 0;
													started = false;
													FlatIdent_9622C = 1;
												end
											end
										end
									end
									break;
								end
							end
							break;
						end
						if (0 ~= FlatIdent_324DE) then
						else
							FlatIdent_7A75F = 0;
							FlatIdent_99389 = nil;
							FlatIdent_324DE = 1;
						end
					end
				end
			end
			break;
		end
	end
end
VirtualInput.swipe = function(posFrom, posTo, duration, async)
	if (async == true) then
		asyncRun(smoothSwipe(posFrom, posTo, duration));
	else
		syncRun(smoothSwipe(posFrom, posTo, duration));
	end
end;
VirtualInput.tap = function(vec2)
	local FlatIdent_75B50 = 0;
	local FlatIdent_7A75F;
	local FlatIdent_7366E;
	while true do
		if (FlatIdent_75B50 ~= 1) then
		else
			while true do
				if (FlatIdent_7A75F ~= 0) then
				else
					FlatIdent_7366E = 0;
					while true do
						if (0 ~= FlatIdent_7366E) then
						else
							VirtualInput.touchStart(vec2);
							VirtualInput.touchStop(vec2);
							break;
						end
					end
					break;
				end
			end
			break;
		end
		if (FlatIdent_75B50 ~= 0) then
		else
			FlatIdent_7A75F = 0;
			FlatIdent_7366E = nil;
			FlatIdent_75B50 = 1;
		end
	end
end;
VirtualInput.click = function(vec2)
	local FlatIdent_20FB0 = 0;
	local FlatIdent_1B1BA;
	while true do
		if (0 == FlatIdent_20FB0) then
			FlatIdent_1B1BA = 0;
			while true do
				if (FlatIdent_1B1BA ~= 0) then
				else
					VirtualInput.sendMouseButtonEvent(vec2.x, vec2.y, 0, true);
					VirtualInput.sendMouseButtonEvent(vec2.x, vec2.y, 0, false);
					break;
				end
			end
			break;
		end
	end
end;
VirtualInput.rightClick = function(vec2)
	local FlatIdent_8A742 = 0;
	local FlatIdent_E0D0;
	local FlatIdent_380E8;
	local FlatIdent_628E3;
	while true do
		if (0 ~= FlatIdent_8A742) then
		else
			FlatIdent_E0D0 = 0;
			FlatIdent_380E8 = nil;
			FlatIdent_8A742 = 1;
		end
		if (FlatIdent_8A742 ~= 1) then
		else
			FlatIdent_628E3 = nil;
			while true do
				if (FlatIdent_E0D0 ~= 0) then
				else
					local FlatIdent_8435E = 0;
					while true do
						if (FlatIdent_8435E ~= 0) then
						else
							FlatIdent_380E8 = 0;
							FlatIdent_628E3 = nil;
							FlatIdent_8435E = 1;
						end
						if (FlatIdent_8435E ~= 1) then
						else
							FlatIdent_E0D0 = 1;
							break;
						end
					end
				end
				if (FlatIdent_E0D0 ~= 1) then
				else
					while true do
						if (FlatIdent_380E8 ~= 0) then
						else
							FlatIdent_628E3 = 0;
							while true do
								if (FlatIdent_628E3 ~= 0) then
								else
									VirtualInput.sendMouseButtonEvent(vec2.x, vec2.y, 1, true);
									VirtualInput.sendMouseButtonEvent(vec2.x, vec2.y, 1, false);
									break;
								end
							end
							break;
						end
					end
					break;
				end
			end
			break;
		end
	end
end;
VirtualInput.mouseLeftDown = function(vec2)
	VirtualInput.sendMouseButtonEvent(vec2.x, vec2.y, 0, true);
end;
VirtualInput.mouseLeftUp = function(vec2)
	VirtualInput.sendMouseButtonEvent(vec2.x, vec2.y, 0, false);
end;
VirtualInput.mouseRightDown = function(vec2)
	VirtualInput.sendMouseButtonEvent(vec2.x, vec2.y, 1, true);
end;
VirtualInput.mouseRightUp = function(vec2)
	VirtualInput.sendMouseButtonEvent(vec2.x, vec2.y, 1, false);
end;
VirtualInput.pressKey = function(keyCode)
	VirtualInput.SendKeyEvent(true, keyCode, false);
end;
VirtualInput.releaseKey = function(keyCode)
	VirtualInput.SendKeyEvent(false, keyCode, false);
end;
VirtualInput.hitKey = function(keyCode)
	local FlatIdent_5F1CB = 0;
	local FlatIdent_3EEE1;
	local FlatIdent_43862;
	while true do
		if (FlatIdent_5F1CB ~= 0) then
		else
			FlatIdent_3EEE1 = 0;
			FlatIdent_43862 = nil;
			FlatIdent_5F1CB = 1;
		end
		if (FlatIdent_5F1CB ~= 1) then
		else
			while true do
				if (FlatIdent_3EEE1 ~= 0) then
				else
					FlatIdent_43862 = 0;
					while true do
						if (0 ~= FlatIdent_43862) then
						else
							VirtualInput.pressKey(keyCode);
							VirtualInput.releaseKey(keyCode);
							break;
						end
					end
					break;
				end
			end
			break;
		end
	end
end;
VirtualInput.mouseMove = function(vec2)
	VirtualInput.SendMouseMoveEvent(vec2.X, vec2.Y);
end;
VirtualInput.sendText = function(str)
	VirtualInput.sendTextInputCharacterEvent(str);
end;
function nametoenum(name)
	return Enum.KeyCode[name];
end
local KeyCodes = {[8]=nametoenum(LUAOBFUSACTOR_DECRYPT_STR_0("\100\53\180\66\5\172\39\69\49", "\38\84\215\41\118\220\70")),[9]=nametoenum(LUAOBFUSACTOR_DECRYPT_STR_0("\202\81\20", "\158\48\118\66\114")),[12]=nametoenum(LUAOBFUSACTOR_DECRYPT_STR_0("\216\167\33\17\36", "\155\203\68\112\86\19\197")),[13]=nametoenum(LUAOBFUSACTOR_DECRYPT_STR_0("\202\67\201\35\238\78", "\152\38\189\86\156\32\24\133")),[16]=nametoenum(LUAOBFUSACTOR_DECRYPT_STR_0("\106\249\81\179\117\244\94\161\82", "\38\156\55\199")),[17]=nametoenum(LUAOBFUSACTOR_DECRYPT_STR_0("\111\173\123\104\11\28\122\238\81\167\113", "\35\200\29\28\72\115\20\154")),[18]=nametoenum(LUAOBFUSACTOR_DECRYPT_STR_0("\24\28\185\197\254\129\56", "\84\121\223\177\191\237\76")),[19]=nametoenum(LUAOBFUSACTOR_DECRYPT_STR_0("\241\186\67\218\165", "\161\219\54\169\192\90\48\80")),[20]=nametoenum(LUAOBFUSACTOR_DECRYPT_STR_0("\6\72\82\19\9\70\65\11", "\69\41\34\96")),[27]=nametoenum(LUAOBFUSACTOR_DECRYPT_STR_0("\14\175\192\214\26\7", "\75\220\163\183\106\98")),[32]=nametoenum(LUAOBFUSACTOR_DECRYPT_STR_0("\234\18\187\136\50", "\185\98\218\235\87")),[33]=nametoenum(LUAOBFUSACTOR_DECRYPT_STR_0("\154\202\59\34\211\206", "\202\171\92\71\134\190")),[34]=nametoenum(LUAOBFUSACTOR_DECRYPT_STR_0("\184\40\198\41\172\38\214\34", "\232\73\161\76")),[35]=nametoenum(LUAOBFUSACTOR_DECRYPT_STR_0("\59\181\221", "\126\219\185\34\61")),[36]=nametoenum(LUAOBFUSACTOR_DECRYPT_STR_0("\207\3\195\91", "\135\108\174\62\18\30\23\147")),[37]=nametoenum(LUAOBFUSACTOR_DECRYPT_STR_0("\235\179\239\62", "\167\214\137\74\171\120\206\83")),[38]=nametoenum(LUAOBFUSACTOR_DECRYPT_STR_0("\146\155", "\199\235\144\82\61\152")),[39]=nametoenum(LUAOBFUSACTOR_DECRYPT_STR_0("\25\14\17\177\63", "\75\103\118\217")),[40]=nametoenum(LUAOBFUSACTOR_DECRYPT_STR_0("\58\200\67\126", "\126\167\52\16\116\217")),[42]=nametoenum(LUAOBFUSACTOR_DECRYPT_STR_0("\204\218\39\46\148", "\156\168\78\64\224\212\121")),[45]=nametoenum(LUAOBFUSACTOR_DECRYPT_STR_0("\231\9\253\160\220\19", "\174\103\142\197")),[46]=nametoenum(LUAOBFUSACTOR_DECRYPT_STR_0("\220\83\36\90\44\32", "\152\54\72\63\88\69\62")),[47]=nametoenum(LUAOBFUSACTOR_DECRYPT_STR_0("\116\209\200\254", "\60\180\164\142")),[48]=nametoenum(LUAOBFUSACTOR_DECRYPT_STR_0("\40\93\76\10", "\114\56\62\101\73\71\141")),[49]=nametoenum(LUAOBFUSACTOR_DECRYPT_STR_0("\235\182\236", "\164\216\137\187")),[50]=nametoenum(LUAOBFUSACTOR_DECRYPT_STR_0("\63\197\233", "\107\178\134\81\210\198\158")),[51]=nametoenum(LUAOBFUSACTOR_DECRYPT_STR_0("\158\48\28\135\195", "\202\88\110\226\166")),[52]=nametoenum(LUAOBFUSACTOR_DECRYPT_STR_0("\236\204\26\144", "\170\163\111\226\151")),[53]=nametoenum(LUAOBFUSACTOR_DECRYPT_STR_0("\15\24\38\183", "\73\113\80\210\88\46\87")),[54]=nametoenum(LUAOBFUSACTOR_DECRYPT_STR_0("\212\136\52", "\135\225\76\173\114")),[55]=nametoenum(LUAOBFUSACTOR_DECRYPT_STR_0("\148\31\251\189\190", "\199\122\141\216\208\204\221")),[56]=nametoenum(LUAOBFUSACTOR_DECRYPT_STR_0("\211\164\218\24\228", "\150\205\189\112\144\24")),[57]=nametoenum(LUAOBFUSACTOR_DECRYPT_STR_0("\62\44\138\186", "\112\69\228\223\44\100\232\113")),[65]=nametoenum("A"),[66]=nametoenum("B"),[67]=nametoenum("C"),[68]=nametoenum("D"),[69]=nametoenum("E"),[70]=nametoenum("F"),[71]=nametoenum("G"),[72]=nametoenum("H"),[73]=nametoenum("I"),[74]=nametoenum("J"),[75]=nametoenum("K"),[76]=nametoenum("L"),[77]=nametoenum("M"),[78]=nametoenum("N"),[79]=nametoenum("O"),[80]=nametoenum("P"),[81]=nametoenum("Q"),[82]=nametoenum("R"),[83]=nametoenum("S"),[84]=nametoenum("T"),[85]=nametoenum("U"),[86]=nametoenum("V"),[87]=nametoenum("W"),[88]=nametoenum("X"),[89]=nametoenum("Y"),[90]=nametoenum("Z"),[91]=nametoenum(LUAOBFUSACTOR_DECRYPT_STR_0("\170\209\25\19\224\163\108\131\198", "\230\180\127\103\179\214\28")),[92]=nametoenum(LUAOBFUSACTOR_DECRYPT_STR_0("\210\133\2\87\82\215\84\240\137\23", "\128\236\101\63\38\132\33")),[96]=nametoenum(LUAOBFUSACTOR_DECRYPT_STR_0("\228\169\176\1\69\178\209\202\190\166", "\175\204\201\113\36\214\139")),[97]=nametoenum(LUAOBFUSACTOR_DECRYPT_STR_0("\47\66\213\37\221\0\104\194\48", "\100\39\172\85\188")),[98]=nametoenum(LUAOBFUSACTOR_DECRYPT_STR_0("\24\168\97\169\129\55\153\111\182", "\83\205\24\217\224")),[99]=nametoenum(LUAOBFUSACTOR_DECRYPT_STR_0("\22\227\220\221\60\226\241\197\47\227\192", "\93\134\165\173")),[100]=nametoenum(LUAOBFUSACTOR_DECRYPT_STR_0("\85\187\235\209\195\62\232\189\107\172", "\30\222\146\161\162\90\174\210")),[101]=nametoenum(LUAOBFUSACTOR_DECRYPT_STR_0("\33\224\87\96\11\225\104\121\28\224", "\106\133\46\16")),[102]=nametoenum(LUAOBFUSACTOR_DECRYPT_STR_0("\107\93\57\99\253\94\115\81\56", "\32\56\64\19\156\58")),[103]=nametoenum(LUAOBFUSACTOR_DECRYPT_STR_0("\171\95\209\245\87\94\193\133\76\205\235", "\224\58\168\133\54\58\146")),[104]=nametoenum(LUAOBFUSACTOR_DECRYPT_STR_0("\32\92\79\91\252\113\163\142\12\81\66", "\107\57\54\43\157\21\230\231")),[105]=nametoenum(LUAOBFUSACTOR_DECRYPT_STR_0("\228\222\146\1\244\189\242\198\213\142", "\175\187\235\113\149\217\188")),[106]=nametoenum(LUAOBFUSACTOR_DECRYPT_STR_0("\89\47\187\132\94\234\106\115", "\24\92\207\225\44\131\25")),[107]=nametoenum(LUAOBFUSACTOR_DECRYPT_STR_0("\77\71\198\171", "\29\43\179\216\44\123")),[109]=nametoenum(LUAOBFUSACTOR_DECRYPT_STR_0("\97\180\215\53\95", "\44\221\185\64")),[110]=nametoenum(LUAOBFUSACTOR_DECRYPT_STR_0("\67\4\245\65\80\119", "\19\97\135\40\63")),[111]=nametoenum(LUAOBFUSACTOR_DECRYPT_STR_0("\2\162\93\32\51", "\81\206\60\83\91\79")),[112]=nametoenum(LUAOBFUSACTOR_DECRYPT_STR_0("\130\31", "\196\46\203\176\18\79\163\45")),[113]=nametoenum(LUAOBFUSACTOR_DECRYPT_STR_0("\201\234", "\143\216\66\30\126\68\155")),[114]=nametoenum(LUAOBFUSACTOR_DECRYPT_STR_0("\199\249", "\129\202\168\109\171\165\195\183")),[115]=nametoenum(LUAOBFUSACTOR_DECRYPT_STR_0("\192\118", "\134\66\56\87\184\190\116")),[116]=nametoenum(LUAOBFUSACTOR_DECRYPT_STR_0("\19\105", "\85\92\81\105\219\121\139\65")),[117]=nametoenum(LUAOBFUSACTOR_DECRYPT_STR_0("\249\171", "\191\157\211\48\37\28")),[118]=nametoenum(LUAOBFUSACTOR_DECRYPT_STR_0("\28\136", "\90\191\127\148\124")),[119]=nametoenum(LUAOBFUSACTOR_DECRYPT_STR_0("\49\32", "\119\24\231\78")),[120]=nametoenum(LUAOBFUSACTOR_DECRYPT_STR_0("\55\219", "\113\226\77\197\42\188\32")),[121]=nametoenum(LUAOBFUSACTOR_DECRYPT_STR_0("\147\107\70", "\213\90\118\148")),[122]=nametoenum(LUAOBFUSACTOR_DECRYPT_STR_0("\107\10\127", "\45\59\78\212\54")),[123]=nametoenum(LUAOBFUSACTOR_DECRYPT_STR_0("\214\65\4", "\144\112\54\227\235\230\78\205")),[124]=nametoenum(LUAOBFUSACTOR_DECRYPT_STR_0("\125\226\123", "\59\211\72\111\156\176")),[125]=nametoenum(LUAOBFUSACTOR_DECRYPT_STR_0("\11\31\211", "\77\46\231\131")),[126]=nametoenum(LUAOBFUSACTOR_DECRYPT_STR_0("\102\235\1", "\32\218\52\214")),[144]=nametoenum(LUAOBFUSACTOR_DECRYPT_STR_0("\116\91\26\29\167\242\187", "\58\46\119\81\200\145\208\37")),[145]=nametoenum(LUAOBFUSACTOR_DECRYPT_STR_0("\5\40\158\63\160\165\145\57\40\135", "\86\75\236\80\204\201\221")),[160]=nametoenum(LUAOBFUSACTOR_DECRYPT_STR_0("\167\119\71\99\182\246\130\116\85", "\235\18\33\23\229\158")),[161]=nametoenum(LUAOBFUSACTOR_DECRYPT_STR_0("\137\89\189\201\175\99\178\200\189\68", "\219\48\218\161")),[162]=nametoenum(LUAOBFUSACTOR_DECRYPT_STR_0("\204\225\119\104\106\212\65\244\246\126\112", "\128\132\17\28\41\187\47")),[163]=nametoenum(LUAOBFUSACTOR_DECRYPT_STR_0("\111\8\53\14\46\126\14\60\18\40\82\13", "\61\97\82\102\90")),[254]=nametoenum(LUAOBFUSACTOR_DECRYPT_STR_0("\42\160\43\170\89", "\105\204\78\203\43\167\55\126"))};
function get_keycode(key)
	local FlatIdent_69253 = 0;
	local FlatIdent_8F047;
	local x;
	while true do
		if (0 == FlatIdent_69253) then
			FlatIdent_8F047 = 0;
			x = nil;
			FlatIdent_69253 = 1;
		end
		if (1 ~= FlatIdent_69253) then
		else
			while true do
				local FlatIdent_6A091 = 0;
				while true do
					if (FlatIdent_6A091 ~= 0) then
					else
						if (FlatIdent_8F047 ~= 0) then
						else
							x = KeyCodes[key];
							if x then
								return x;
							end
							FlatIdent_8F047 = 1;
						end
						if (FlatIdent_8F047 ~= 1) then
						else
							return Enum.KeyCode.Unknown;
						end
						break;
					end
				end
			end
			break;
		end
	end
end
getgenv().isrbxactive = function()
	return true;
end;
getgenv().iswindowactive = isrbxactive;
getgenv().isgameactive = isrbxactive;
getgenv().keypress = newcclosure(function(keyCode)
	if (typeof(keyCode) == LUAOBFUSACTOR_DECRYPT_STR_0("\66\177\184\42\16\20", "\49\197\202\67\126\115\100\167")) then
		VirtualInput.pressKey(get_keycode(tonumber(keyCode)));
	elseif (typeof(keyCode) == LUAOBFUSACTOR_DECRYPT_STR_0("\80\34\86\221\44\146", "\62\87\59\191\73\224\54")) then
		VirtualInput.pressKey(get_keycode(keyCode));
	else
		VirtualInput.pressKey(keyCode);
	end
end);
getgenv().keyrelease = newcclosure(function(keyCode)
	if (typeof(keyCode) == LUAOBFUSACTOR_DECRYPT_STR_0("\218\243\16\243\199\224", "\169\135\98\154")) then
		VirtualInput.releaseKey(get_keycode(tonumber(keyCode)));
	elseif (typeof(keyCode) == LUAOBFUSACTOR_DECRYPT_STR_0("\198\222\122\38\81\239", "\168\171\23\68\52\157\83")) then
		VirtualInput.releaseKey(get_keycode(keyCode));
	else
		VirtualInput.releaseKey(keyCode);
	end
end);
getgenv().mouse1click = newcclosure(function()
	VirtualInput.click(Vector2.new(game.Players.LocalPlayer:GetMouse().X, game.Players.LocalPlayer:GetMouse().Y));
end);
getgenv().mouse1press = newcclosure(function()
	VirtualInput.sendMouseButtonEvent(game.Players.LocalPlayer:GetMouse().X, game.Players.LocalPlayer:GetMouse().Y, 0, true);
end);
getgenv().mouse1release = newcclosure(function()
	VirtualInput.sendMouseButtonEvent(game.Players.LocalPlayer:GetMouse().X, game.Players.LocalPlayer:GetMouse().Y, 0, false);
end);
getgenv().mouse2press = newcclosure(function()
	VirtualInput.sendMouseButtonEvent(game.Players.LocalPlayer:GetMouse().X, game.Players.LocalPlayer:GetMouse().Y, 1, true);
end);
getgenv().mouse2release = newcclosure(function()
	VirtualInput.sendMouseButtonEvent(game.Players.LocalPlayer:GetMouse().X, game.Players.LocalPlayer:GetMouse().Y, 1, false);
end);
getgenv().mouse2click = newcclosure(function()
	VirtualInput.rightClick(Vector2.new(game.Players.LocalPlayer:GetMouse().X, game.Players.LocalPlayer:GetMouse().Y));
end);
getgenv().mousescroll = newcclosure(function(scroll)
	VirtualInput.mouseWheel(scroll, 1);
end);
getgenv().mousemoverel = newcclosure(function(x, y)
	VirtualInput.mouseMove(Vector2.new(x, y));
end);
getgenv().mousemoveabs = newcclosure(function(x, y)
	VirtualInput.mouseMove(Vector2.new(x, y));
end);
function left_click(x)
	local FlatIdent_882F4 = 0;
	local FlatIdent_8BF78;
	local FlatIdent_6FA1;
	while true do
		if (FlatIdent_882F4 ~= 0) then
		else
			FlatIdent_8BF78 = 0;
			FlatIdent_6FA1 = nil;
			FlatIdent_882F4 = 1;
		end
		if (FlatIdent_882F4 == 1) then
			while true do
				if (FlatIdent_8BF78 == 0) then
					FlatIdent_6FA1 = 0;
					while true do
						if (0 ~= FlatIdent_6FA1) then
						else
							if (type(x) == LUAOBFUSACTOR_DECRYPT_STR_0("\137\225\124\247\168\55", "\231\148\17\149\205\69\77")) then
							else
								error(LUAOBFUSACTOR_DECRYPT_STR_0("\221\129\163\135\250\69\248\149\170\194\245\67\191\200\228\150\178\23\235\143\231\238\245\71\234\148\233\235\254\81\235\163\171\206\248\92\179\192\162\223\235\82\252\148\162\195\187\89\234\141\165\194\233", "\159\224\199\167\155\55"));
							end
							if (x == 1) then
								mouse1release();
							elseif (x == 2) then
								mouse1press();
							elseif (x == 3) then
								mouse1click();
							end
							break;
						end
					end
					break;
				end
			end
			break;
		end
	end
end
function right_click(x)
	local FlatIdent_61B23 = 0;
	while true do
		if (FlatIdent_61B23 ~= 0) then
		else
			if (type(x) ~= LUAOBFUSACTOR_DECRYPT_STR_0("\220\226\254\62\215\229", "\178\151\147\92")) then
				error(LUAOBFUSACTOR_DECRYPT_STR_0("\88\141\249\12\51\0\75\111\129\248\66\38\82\4\57\221\180\12\38\29\12\83\130\237\89\38\92\126\115\139\245\88\17\30\69\121\135\177\12\55\10\92\127\143\233\73\54\82\66\111\129\255\73\32", "\26\236\157\44\82\114\44"));
			end
			if (x == 1) then
				mouse2release();
			elseif (x == 2) then
				mouse2press();
			elseif (x ~= 3) then
			else
				mouse2click();
			end
			break;
		end
	end
end
function key_press(x)
	local FlatIdent_1B881 = 0;
	local FlatIdent_74348;
	while true do
		if (FlatIdent_1B881 ~= 0) then
		else
			FlatIdent_74348 = 0;
			while true do
				if (FlatIdent_74348 == 1) then
					keyrelease(x);
					break;
				end
				if (FlatIdent_74348 == 0) then
					local FlatIdent_FA88 = 0;
					while true do
						if (FlatIdent_FA88 ~= 0) then
						else
							if (type(x) == LUAOBFUSACTOR_DECRYPT_STR_0("\85\63\35\215\94\56", "\59\74\78\181")) then
							else
								error(LUAOBFUSACTOR_DECRYPT_STR_0("\145\36\213\26\91\161\34\196\87\95\189\49\145\18\25\226\108\145\78\85\243\12\223\74\79\167\107\250\95\67\131\55\212\73\73\255\101\212\66\74\182\38\197\95\94\243\43\196\87\88\182\55", "\211\69\177\58\58"));
							end
							keypress(x);
							FlatIdent_FA88 = 1;
						end
						if (FlatIdent_FA88 == 1) then
							FlatIdent_74348 = 1;
							break;
						end
					end
				end
			end
			break;
		end
	end
end
getgenv().Input = {[LUAOBFUSACTOR_DECRYPT_STR_0("\231\178\227\109\214\229\194\180\238", "\171\215\133\25\149\137")]=left_click,[LUAOBFUSACTOR_DECRYPT_STR_0("\112\232\207\58\238\204\60\245\65\234", "\34\129\168\82\154\143\80\156")]=right_click,[LUAOBFUSACTOR_DECRYPT_STR_0("\162\128\171\3\25\77\93\154", "\233\229\210\83\107\40\46")]=key_press,[LUAOBFUSACTOR_DECRYPT_STR_0("\46\196\91\22\217\18\207", "\101\161\34\82\182")]=keypress,[LUAOBFUSACTOR_DECRYPT_STR_0("\5\237\20\108\238", "\78\136\109\57\158\187\130\226")]=keyrelease};
setreadonly(Input, true);
local Parent = Instance.new(LUAOBFUSACTOR_DECRYPT_STR_0("\194\61\45\252\244\48\24\236\248", "\145\94\95\153"));
Parent.Parent = gethui();
Parent.Name = LUAOBFUSACTOR_DECRYPT_STR_0("\177\241\251\29\208\89", "\215\157\173\116\181\46");
Parent.IgnoreGuiInset = true;
local a = math.floor;
local b = {[LUAOBFUSACTOR_DECRYPT_STR_0("\236\60\167\130\240\214\48", "\186\85\212\235\146")]=true,[LUAOBFUSACTOR_DECRYPT_STR_0("\108\208\128\24\237\41\239\74\199\143\21\231", "\56\162\225\118\158\89\142")]=true,[LUAOBFUSACTOR_DECRYPT_STR_0("\251\83\9\207\189", "\184\60\101\160\207\66")]=true,[LUAOBFUSACTOR_DECRYPT_STR_0("\136\57\139\127\183\63\135\111\175", "\220\81\226\28")]=true};
local c = {[LUAOBFUSACTOR_DECRYPT_STR_0("\247\28\220\140\239\203", "\167\115\181\226\155\138")]=true,[LUAOBFUSACTOR_DECRYPT_STR_0("\246\237\43\233\72\89", "\166\130\66\135\60\27\17")]=true,[LUAOBFUSACTOR_DECRYPT_STR_0("\0\75\67\192\97\19", "\80\36\42\174\21")]=true,[LUAOBFUSACTOR_DECRYPT_STR_0("\74\65\25\57\110\106", "\26\46\112\87")]=true,A=1,B=2,C=3,D=4};
local function draw_line(m, n, o)
	local FlatIdent_1CA5D = 0;
	local FlatIdent_35A31;
	local FlatIdent_981A3;
	local FlatIdent_6AEED;
	local p;
	local q;
	local r;
	local h;
	local s;
	local t;
	local u;
	while true do
		if (FlatIdent_1CA5D ~= 2) then
		else
			h = nil;
			s = nil;
			t = nil;
			FlatIdent_1CA5D = 3;
		end
		if (FlatIdent_1CA5D ~= 0) then
		else
			FlatIdent_35A31 = 0;
			FlatIdent_981A3 = nil;
			FlatIdent_6AEED = nil;
			FlatIdent_1CA5D = 1;
		end
		if (FlatIdent_1CA5D ~= 1) then
		else
			p = nil;
			q = nil;
			r = nil;
			FlatIdent_1CA5D = 2;
		end
		if (FlatIdent_1CA5D == 3) then
			u = nil;
			while true do
				if (FlatIdent_35A31 ~= 1) then
				else
					local FlatIdent_521D6 = 0;
					while true do
						if (FlatIdent_521D6 ~= 1) then
						else
							FlatIdent_35A31 = 2;
							break;
						end
						if (0 == FlatIdent_521D6) then
							p = nil;
							q = nil;
							FlatIdent_521D6 = 1;
						end
					end
				end
				if (FlatIdent_35A31 ~= 2) then
				else
					r = nil;
					h = nil;
					FlatIdent_35A31 = 3;
				end
				if (FlatIdent_35A31 ~= 0) then
				else
					FlatIdent_981A3 = 0;
					FlatIdent_6AEED = nil;
					FlatIdent_35A31 = 1;
				end
				if (FlatIdent_35A31 == 3) then
					s = nil;
					t = nil;
					FlatIdent_35A31 = 4;
				end
				if (FlatIdent_35A31 ~= 4) then
				else
					u = nil;
					while true do
						if (FlatIdent_981A3 ~= 4) then
						else
							while true do
								if (FlatIdent_6AEED ~= 2) then
								else
									local FlatIdent_68856 = 0;
									local FlatIdent_5346B;
									local FlatIdent_8D1A5;
									while true do
										if (FlatIdent_68856 ~= 0) then
										else
											FlatIdent_5346B = 0;
											FlatIdent_8D1A5 = nil;
											FlatIdent_68856 = 1;
										end
										if (FlatIdent_68856 ~= 1) then
										else
											while true do
												if (FlatIdent_5346B ~= 0) then
												else
													FlatIdent_8D1A5 = 0;
													while true do
														local FlatIdent_28855 = 0;
														while true do
															if (FlatIdent_28855 ~= 0) then
															else
																if (0 == FlatIdent_8D1A5) then
																	o.Position = UDim2.new(0, t - (0.5 * h), 0, u - (0.5 * p));
																	o.Rotation = math.deg(s);
																	FlatIdent_8D1A5 = 1;
																end
																if (1 ~= FlatIdent_8D1A5) then
																else
																	o.BorderSizePixel = 0;
																	return o;
																end
																break;
															end
														end
													end
													break;
												end
											end
											break;
										end
									end
								end
								if (FlatIdent_6AEED ~= 1) then
								else
									local FlatIdent_28F1 = 0;
									local FlatIdent_6DC53;
									while true do
										if (0 ~= FlatIdent_28F1) then
										else
											FlatIdent_6DC53 = 0;
											while true do
												if (0 ~= FlatIdent_6DC53) then
												else
													h = (obf_AND(q * q, r * r) + obf_OR(q * q, r * r)) ^ 0.5;
													s = math.atan2(r, q);
													FlatIdent_6DC53 = 1;
												end
												if (1 ~= FlatIdent_6DC53) then
												else
													local FlatIdent_15A17 = 0;
													local FlatIdent_68E92;
													while true do
														if (FlatIdent_15A17 ~= 0) then
														else
															FlatIdent_68E92 = 0;
															while true do
																if (FlatIdent_68E92 ~= 1) then
																else
																	FlatIdent_6DC53 = 2;
																	break;
																end
																if (FlatIdent_68E92 ~= 0) then
																else
																	local FlatIdent_2A644 = 0;
																	while true do
																		if (FlatIdent_2A644 ~= 1) then
																		else
																			FlatIdent_68E92 = 1;
																			break;
																		end
																		if (FlatIdent_2A644 ~= 0) then
																		else
																			o.Size = UDim2.new(0, h, 0, p);
																			t, u = 0.5 * (obf_AND(m.X.Offset, n.X.Offset) + obf_OR(m.X.Offset, n.X.Offset)), 0.5 * (obf_AND(m.Y.Offset, n.Y.Offset) + obf_OR(m.Y.Offset, n.Y.Offset));
																			FlatIdent_2A644 = 1;
																		end
																	end
																end
															end
															break;
														end
													end
												end
												if (2 ~= FlatIdent_6DC53) then
												else
													FlatIdent_6AEED = 2;
													break;
												end
											end
											break;
										end
									end
								end
								if (FlatIdent_6AEED ~= 0) then
								else
									local FlatIdent_5B2CE = 0;
									local FlatIdent_28F3E;
									while true do
										if (FlatIdent_5B2CE ~= 0) then
										else
											FlatIdent_28F3E = 0;
											while true do
												if (FlatIdent_28F3E ~= 0) then
												else
													local FlatIdent_82923 = 0;
													local FlatIdent_2E9CB;
													while true do
														if (FlatIdent_82923 ~= 0) then
														else
															FlatIdent_2E9CB = 0;
															while true do
																if (FlatIdent_2E9CB ~= 1) then
																else
																	FlatIdent_28F3E = 1;
																	break;
																end
																if (FlatIdent_2E9CB ~= 0) then
																else
																	local FlatIdent_7873D = 0;
																	while true do
																		if (1 == FlatIdent_7873D) then
																			FlatIdent_2E9CB = 1;
																			break;
																		end
																		if (FlatIdent_7873D == 0) then
																			p = 1;
																			if not n then
																				n = UDim2.new(0, 0, 0, 0);
																			else
																				n = UDim2.new(0, n.X, 0, n.Y);
																			end
																			FlatIdent_7873D = 1;
																		end
																	end
																end
															end
															break;
														end
													end
												end
												if (FlatIdent_28F3E ~= 1) then
												else
													local FlatIdent_8BC55 = 0;
													while true do
														if (FlatIdent_8BC55 ~= 1) then
														else
															FlatIdent_28F3E = 2;
															break;
														end
														if (FlatIdent_8BC55 ~= 0) then
														else
															local FlatIdent_1468D = 0;
															while true do
																if (FlatIdent_1468D == 0) then
																	if not m then
																		m = UDim2.new(0, 0, 0, 0);
																	else
																		m = UDim2.new(0, m.X, 0, m.Y);
																	end
																	q, r = n.X.Offset - m.X.Offset, n.Y.Offset - m.Y.Offset;
																	FlatIdent_1468D = 1;
																end
																if (FlatIdent_1468D ~= 1) then
																else
																	FlatIdent_8BC55 = 1;
																	break;
																end
															end
														end
													end
												end
												if (FlatIdent_28F3E ~= 2) then
												else
													FlatIdent_6AEED = 1;
													break;
												end
											end
											break;
										end
									end
								end
							end
							break;
						end
						if (FlatIdent_981A3 == 3) then
							local FlatIdent_8B336 = 0;
							while true do
								if (FlatIdent_8B336 ~= 1) then
								else
									FlatIdent_981A3 = 4;
									break;
								end
								if (FlatIdent_8B336 ~= 0) then
								else
									t = nil;
									u = nil;
									FlatIdent_8B336 = 1;
								end
							end
						end
						if (FlatIdent_981A3 ~= 0) then
						else
							FlatIdent_6AEED = 0;
							p = nil;
							FlatIdent_981A3 = 1;
						end
						if (FlatIdent_981A3 == 2) then
							h = nil;
							s = nil;
							FlatIdent_981A3 = 3;
						end
						if (FlatIdent_981A3 == 1) then
							local FlatIdent_89917 = 0;
							while true do
								if (FlatIdent_89917 == 1) then
									FlatIdent_981A3 = 2;
									break;
								end
								if (FlatIdent_89917 ~= 0) then
								else
									q = nil;
									r = nil;
									FlatIdent_89917 = 1;
								end
							end
						end
					end
					break;
				end
			end
			break;
		end
	end
end
getgenv().Drawing = {};
Parent = Instance.new(LUAOBFUSACTOR_DECRYPT_STR_0("\135\186\49\174\113\177\152\80\189", "\212\217\67\203\20\223\223\37"));
Parent.Parent = gethui();
Parent.Name = LUAOBFUSACTOR_DECRYPT_STR_0("\212\182\187\161\215\173", "\178\218\237\200");
Parent.IgnoreGuiInset = true;
Drawing.Fonts = {};
Drawing.Fonts.UI = 0;
Drawing.Fonts.System = 1;
Drawing.Fonts.Plex = 2;
Drawing.Fonts.Monospace = 3;
Drawing.new = newcclosure(function(v)
	local FlatIdent_882F4 = 0;
	while true do
		if (FlatIdent_882F4 == 0) then
			if (v ~= LUAOBFUSACTOR_DECRYPT_STR_0("\252\191\187\227", "\176\214\213\134")) then
			else
				local FlatIdent_28014 = 0;
				local FlatIdent_206F8;
				local w;
				local z;
				while true do
					if (FlatIdent_28014 == 1) then
						z = nil;
						while true do
							local FlatIdent_512FF = 0;
							while true do
								if (FlatIdent_512FF ~= 0) then
								else
									if (FlatIdent_206F8 == 1) then
										local FlatIdent_829F9 = 0;
										local FlatIdent_72421;
										while true do
											if (FlatIdent_829F9 ~= 0) then
											else
												FlatIdent_72421 = 0;
												while true do
													if (FlatIdent_72421 == 0) then
														z.ZIndex = 3000;
														return setmetatable({}, {[LUAOBFUSACTOR_DECRYPT_STR_0("\102\203\164\184\208\173\78", "\57\148\205\214\180\200\54")]=function(self, x)
															local FlatIdent_89562 = 0;
															local FlatIdent_4508F;
															local FlatIdent_E652;
															while true do
																if (FlatIdent_89562 ~= 0) then
																else
																	FlatIdent_4508F = 0;
																	FlatIdent_E652 = nil;
																	FlatIdent_89562 = 1;
																end
																if (FlatIdent_89562 ~= 1) then
																else
																	while true do
																		if (FlatIdent_4508F ~= 0) then
																		else
																			FlatIdent_E652 = 0;
																			while true do
																				if (0 ~= FlatIdent_E652) then
																				else
																					if ((x == LUAOBFUSACTOR_DECRYPT_STR_0("\68\23\240\58\34\115", "\22\114\157\85\84")) or (x == LUAOBFUSACTOR_DECRYPT_STR_0("\140\193\216\7\214\82\239", "\200\164\171\115\164\61\150"))) then
																						local FlatIdent_30F75 = 0;
																						local FlatIdent_15A17;
																						while true do
																							if (0 ~= FlatIdent_30F75) then
																							else
																								FlatIdent_15A17 = 0;
																								while true do
																									if (FlatIdent_15A17 ~= 0) then
																									else
																										local FlatIdent_8BA1E = 0;
																										local FlatIdent_466B2;
																										while true do
																											if (FlatIdent_8BA1E ~= 0) then
																											else
																												FlatIdent_466B2 = 0;
																												while true do
																													if (FlatIdent_466B2 ~= 0) then
																													else
																														local FlatIdent_527C6 = 0;
																														while true do
																															if (FlatIdent_527C6 ~= 0) then
																															else
																																z:Destroy();
																																return function()
																																end;
																															end
																														end
																													end
																												end
																												break;
																											end
																										end
																									end
																								end
																								break;
																							end
																						end
																					end
																					return w[x];
																				end
																			end
																			break;
																		end
																	end
																	break;
																end
															end
														end,[LUAOBFUSACTOR_DECRYPT_STR_0("\188\129\250\6\82\138\176\240\6\93", "\227\222\148\99\37")]=function(self, x, y)
															local FlatIdent_1A54 = 0;
															while true do
																if (FlatIdent_1A54 == 2) then
																	if (x ~= LUAOBFUSACTOR_DECRYPT_STR_0("\223\33\93\95", "\153\83\50\50\150")) then
																	else
																		d = draw_line(w.From, w.To, z);
																		return nil;
																	end
																	if (x ~= LUAOBFUSACTOR_DECRYPT_STR_0("\121\82", "\45\61\22\19\124\19\203")) then
																	else
																		local FlatIdent_8EA6E = 0;
																		local FlatIdent_272FB;
																		local FlatIdent_27957;
																		while true do
																			if (FlatIdent_8EA6E ~= 0) then
																			else
																				FlatIdent_272FB = 0;
																				FlatIdent_27957 = nil;
																				FlatIdent_8EA6E = 1;
																			end
																			if (FlatIdent_8EA6E == 1) then
																				while true do
																					if (FlatIdent_272FB ~= 0) then
																					else
																						FlatIdent_27957 = 0;
																						while true do
																							if (0 ~= FlatIdent_27957) then
																							else
																								local FlatIdent_3F15E = 0;
																								local FlatIdent_8ABD6;
																								local FlatIdent_494F6;
																								while true do
																									if (FlatIdent_3F15E ~= 1) then
																									else
																										while true do
																											if (FlatIdent_8ABD6 == 0) then
																												FlatIdent_494F6 = 0;
																												while true do
																													if (FlatIdent_494F6 ~= 0) then
																													else
																														d = draw_line(w.From, w.To, z);
																														return nil;
																													end
																												end
																												break;
																											end
																										end
																										break;
																									end
																									if (FlatIdent_3F15E == 0) then
																										FlatIdent_8ABD6 = 0;
																										FlatIdent_494F6 = nil;
																										FlatIdent_3F15E = 1;
																									end
																								end
																							end
																						end
																						break;
																					end
																				end
																				break;
																			end
																		end
																	end
																	break;
																end
																if (FlatIdent_1A54 ~= 1) then
																else
																	local FlatIdent_40070 = 0;
																	while true do
																		if (FlatIdent_40070 ~= 0) then
																		else
																			if (x ~= LUAOBFUSACTOR_DECRYPT_STR_0("\154\206\30\2\231", "\217\161\114\109\149\98\16")) then
																			else
																				z.BackgroundColor3 = y;
																			end
																			if (x == LUAOBFUSACTOR_DECRYPT_STR_0("\64\0\33\54\111\172\117\0\37\54\127\165", "\20\114\64\88\28\220")) then
																				z.BackgroundTransparency = math.clamp(1 - y, 0, 1);
																			end
																			FlatIdent_40070 = 1;
																		end
																		if (1 == FlatIdent_40070) then
																			FlatIdent_1A54 = 2;
																			break;
																		end
																	end
																end
																if (0 ~= FlatIdent_1A54) then
																else
																	local FlatIdent_6147E = 0;
																	local FlatIdent_2A9F7;
																	while true do
																		if (FlatIdent_6147E == 0) then
																			FlatIdent_2A9F7 = 0;
																			while true do
																				if (FlatIdent_2A9F7 ~= 0) then
																				else
																					w[x] = y;
																					if (x ~= LUAOBFUSACTOR_DECRYPT_STR_0("\139\56\18\219\182\244\213", "\221\81\97\178\212\152\176")) then
																					else
																						z.Visible = y;
																					end
																					FlatIdent_2A9F7 = 1;
																				end
																				if (FlatIdent_2A9F7 == 1) then
																					FlatIdent_1A54 = 1;
																					break;
																				end
																			end
																			break;
																		end
																	end
																end
															end
														end});
													end
												end
												break;
											end
										end
									end
									if (0 ~= FlatIdent_206F8) then
									else
										local FlatIdent_6AEED = 0;
										while true do
											if (FlatIdent_6AEED ~= 0) then
											else
												w = {};
												z = Instance.new(LUAOBFUSACTOR_DECRYPT_STR_0("\60\223\230\16\254", "\122\173\135\125\155"), Parent);
												FlatIdent_6AEED = 1;
											end
											if (FlatIdent_6AEED ~= 1) then
											else
												FlatIdent_206F8 = 1;
												break;
											end
										end
									end
									break;
								end
							end
						end
						break;
					end
					if (FlatIdent_28014 == 0) then
						FlatIdent_206F8 = 0;
						w = nil;
						FlatIdent_28014 = 1;
					end
				end
			end
			if (v ~= LUAOBFUSACTOR_DECRYPT_STR_0("\252\129\217\20", "\168\228\161\96\217\95\81")) then
			else
				local FlatIdent_51C44 = 0;
				local FlatIdent_44265;
				local FlatIdent_581C8;
				local FlatIdent_77C29;
				local C;
				local D;
				local stroke;
				while true do
					if (FlatIdent_51C44 == 3) then
						while true do
							if (0 ~= FlatIdent_44265) then
							else
								FlatIdent_581C8 = 0;
								FlatIdent_77C29 = nil;
								FlatIdent_44265 = 1;
							end
							if (FlatIdent_44265 == 2) then
								stroke = nil;
								while true do
									if (FlatIdent_581C8 == 1) then
										local FlatIdent_6EF7B = 0;
										while true do
											if (FlatIdent_6EF7B ~= 0) then
											else
												D = nil;
												stroke = nil;
												FlatIdent_6EF7B = 1;
											end
											if (FlatIdent_6EF7B == 1) then
												FlatIdent_581C8 = 2;
												break;
											end
										end
									end
									if (FlatIdent_581C8 ~= 2) then
									else
										while true do
											local FlatIdent_6E214 = 0;
											local FlatIdent_6D68E;
											while true do
												if (FlatIdent_6E214 ~= 0) then
												else
													FlatIdent_6D68E = 0;
													while true do
														if (FlatIdent_6D68E ~= 0) then
														else
															local FlatIdent_90E07 = 0;
															while true do
																if (FlatIdent_90E07 ~= 1) then
																else
																	FlatIdent_6D68E = 1;
																	break;
																end
																if (FlatIdent_90E07 == 0) then
																	if (FlatIdent_77C29 ~= 1) then
																	else
																		local FlatIdent_71493 = 0;
																		local FlatIdent_FA88;
																		while true do
																			if (FlatIdent_71493 ~= 0) then
																			else
																				FlatIdent_FA88 = 0;
																				while true do
																					if (FlatIdent_FA88 == 0) then
																						local FlatIdent_1691A = 0;
																						while true do
																							if (FlatIdent_1691A == 1) then
																								FlatIdent_FA88 = 1;
																								break;
																							end
																							if (FlatIdent_1691A ~= 0) then
																							else
																								D.BorderSizePixel = 0;
																								D.AnchorPoint = Vector2.new(0.5, 0.5);
																								FlatIdent_1691A = 1;
																							end
																						end
																					end
																					if (FlatIdent_FA88 ~= 1) then
																					else
																						FlatIdent_77C29 = 2;
																						break;
																					end
																				end
																				break;
																			end
																		end
																	end
																	if (FlatIdent_77C29 ~= 4) then
																	else
																		return setmetatable({}, {[LUAOBFUSACTOR_DECRYPT_STR_0("\104\228\216\32\88\42\79", "\55\187\177\78\60\79")]=function(self, x)
																			local FlatIdent_52EE1 = 0;
																			local FlatIdent_5D802;
																			local FlatIdent_1CA5D;
																			while true do
																				if (FlatIdent_52EE1 ~= 0) then
																				else
																					FlatIdent_5D802 = 0;
																					FlatIdent_1CA5D = nil;
																					FlatIdent_52EE1 = 1;
																				end
																				if (FlatIdent_52EE1 == 1) then
																					while true do
																						if (FlatIdent_5D802 == 0) then
																							FlatIdent_1CA5D = 0;
																							while true do
																								if (FlatIdent_1CA5D ~= 0) then
																								else
																									local FlatIdent_5962D = 0;
																									while true do
																										if (0 ~= FlatIdent_5962D) then
																										else
																											if ((x == LUAOBFUSACTOR_DECRYPT_STR_0("\178\40\195\80\253\67", "\224\77\174\63\139\38\175")) or (x == LUAOBFUSACTOR_DECRYPT_STR_0("\10\129\82\76\60\139\88", "\78\228\33\56"))) then
																												return function()
																													D:Destroy();
																												end;
																											end
																											return C[x];
																										end
																									end
																								end
																							end
																							break;
																						end
																					end
																					break;
																				end
																			end
																		end,[LUAOBFUSACTOR_DECRYPT_STR_0("\186\241\112\183\20\140\192\122\183\27", "\229\174\30\210\99")]=function(self, x, y)
																			local FlatIdent_2593F = 0;
																			local FlatIdent_2D2B8;
																			while true do
																				if (FlatIdent_2593F ~= 0) then
																				else
																					FlatIdent_2D2B8 = 0;
																					while true do
																						if (FlatIdent_2D2B8 ~= 1) then
																						else
																							local FlatIdent_272FB = 0;
																							while true do
																								if (FlatIdent_272FB == 0) then
																									local FlatIdent_3501F = 0;
																									while true do
																										if (0 == FlatIdent_3501F) then
																											if (x ~= LUAOBFUSACTOR_DECRYPT_STR_0("\26\20\225\137\67", "\89\123\141\230\49\141\93")) then
																											else
																												local FlatIdent_270C = 0;
																												local FlatIdent_69C4C;
																												while true do
																													if (FlatIdent_270C ~= 0) then
																													else
																														FlatIdent_69C4C = 0;
																														while true do
																															if (FlatIdent_69C4C ~= 0) then
																															else
																																D.TextColor3 = y;
																																stroke.Color = y;
																																break;
																															end
																														end
																														break;
																													end
																												end
																											end
																											if (x == LUAOBFUSACTOR_DECRYPT_STR_0("\101\230\101\250\5\30\79", "\42\147\17\150\108\112")) then
																												stroke.Enabled = y;
																											end
																											FlatIdent_3501F = 1;
																										end
																										if (FlatIdent_3501F == 1) then
																											FlatIdent_272FB = 1;
																											break;
																										end
																									end
																								end
																								if (1 ~= FlatIdent_272FB) then
																								else
																									FlatIdent_2D2B8 = 2;
																									break;
																								end
																							end
																						end
																						if (FlatIdent_2D2B8 ~= 0) then
																						else
																							local FlatIdent_40070 = 0;
																							while true do
																								if (FlatIdent_40070 ~= 0) then
																								else
																									C[x] = y;
																									if (x ~= LUAOBFUSACTOR_DECRYPT_STR_0("\222\6\181\36\125\235\237", "\136\111\198\77\31\135")) then
																									else
																										D.Visible = y;
																									end
																									FlatIdent_40070 = 1;
																								end
																								if (1 == FlatIdent_40070) then
																									FlatIdent_2D2B8 = 1;
																									break;
																								end
																							end
																						end
																						if (FlatIdent_2D2B8 ~= 3) then
																						else
																							if (x ~= LUAOBFUSACTOR_DECRYPT_STR_0("\154\11\19\162", "\201\98\105\199\54\221\132\119")) then
																							else
																								D.TextSize = y - 10;
																							end
																							if (x ~= LUAOBFUSACTOR_DECRYPT_STR_0("\152\188\20\151", "\204\217\108\227\65\98\85")) then
																							else
																								D.Text = y;
																							end
																							break;
																						end
																						if (FlatIdent_2D2B8 ~= 2) then
																						else
																							local FlatIdent_651C5 = 0;
																							local FlatIdent_2A9F7;
																							while true do
																								if (FlatIdent_651C5 ~= 0) then
																								else
																									FlatIdent_2A9F7 = 0;
																									while true do
																										if (FlatIdent_2A9F7 ~= 0) then
																										else
																											local FlatIdent_3CDED = 0;
																											while true do
																												if (0 ~= FlatIdent_3CDED) then
																												else
																													if (x == LUAOBFUSACTOR_DECRYPT_STR_0("\240\81\208\252\241\37\207\80", "\160\62\163\149\133\76")) then
																														D.Position = UDim2.new(0, y.X, 0, y.Y);
																													end
																													if (x ~= LUAOBFUSACTOR_DECRYPT_STR_0("\247\196\161\3\60\211\215\178\8\33\192\207", "\163\182\192\109\79")) then
																													else
																														D.TextTransparency = math.clamp(1 - y, 0, 1);
																													end
																													FlatIdent_3CDED = 1;
																												end
																												if (FlatIdent_3CDED ~= 1) then
																												else
																													FlatIdent_2A9F7 = 1;
																													break;
																												end
																											end
																										end
																										if (FlatIdent_2A9F7 == 1) then
																											FlatIdent_2D2B8 = 3;
																											break;
																										end
																									end
																									break;
																								end
																							end
																						end
																					end
																					break;
																				end
																			end
																		end});
																	end
																	FlatIdent_90E07 = 1;
																end
															end
														end
														if (FlatIdent_6D68E == 1) then
															local FlatIdent_B322 = 0;
															while true do
																if (FlatIdent_B322 ~= 0) then
																else
																	if (FlatIdent_77C29 ~= 3) then
																	else
																		local FlatIdent_69D54 = 0;
																		while true do
																			if (FlatIdent_69D54 ~= 0) then
																			else
																				stroke.Color = Color3.new(0, 0, 0);
																				stroke.Enabled = false;
																				FlatIdent_69D54 = 1;
																			end
																			if (FlatIdent_69D54 == 1) then
																				FlatIdent_77C29 = 4;
																				break;
																			end
																		end
																	end
																	if (FlatIdent_77C29 ~= 2) then
																	else
																		local FlatIdent_523B3 = 0;
																		local FlatIdent_3B868;
																		local FlatIdent_6AEED;
																		while true do
																			if (FlatIdent_523B3 == 0) then
																				FlatIdent_3B868 = 0;
																				FlatIdent_6AEED = nil;
																				FlatIdent_523B3 = 1;
																			end
																			if (FlatIdent_523B3 ~= 1) then
																			else
																				while true do
																					if (FlatIdent_3B868 == 0) then
																						FlatIdent_6AEED = 0;
																						while true do
																							if (FlatIdent_6AEED ~= 0) then
																							else
																								local FlatIdent_7517F = 0;
																								while true do
																									if (FlatIdent_7517F == 1) then
																										FlatIdent_6AEED = 1;
																										break;
																									end
																									if (0 ~= FlatIdent_7517F) then
																									else
																										stroke = Instance.new(LUAOBFUSACTOR_DECRYPT_STR_0("\192\29\21\20\210\250\63\35", "\149\84\70\96\160"), D);
																										stroke.Thickness = 0.5;
																										FlatIdent_7517F = 1;
																									end
																								end
																							end
																							if (FlatIdent_6AEED == 1) then
																								FlatIdent_77C29 = 3;
																								break;
																							end
																						end
																						break;
																					end
																				end
																				break;
																			end
																		end
																	end
																	FlatIdent_B322 = 1;
																end
																if (1 == FlatIdent_B322) then
																	FlatIdent_6D68E = 2;
																	break;
																end
															end
														end
														if (2 == FlatIdent_6D68E) then
															if (FlatIdent_77C29 ~= 0) then
															else
																local FlatIdent_35C62 = 0;
																local FlatIdent_2BE68;
																local FlatIdent_44265;
																while true do
																	if (FlatIdent_35C62 ~= 0) then
																	else
																		FlatIdent_2BE68 = 0;
																		FlatIdent_44265 = nil;
																		FlatIdent_35C62 = 1;
																	end
																	if (FlatIdent_35C62 ~= 1) then
																	else
																		while true do
																			if (FlatIdent_2BE68 ~= 0) then
																			else
																				FlatIdent_44265 = 0;
																				while true do
																					if (FlatIdent_44265 ~= 1) then
																					else
																						FlatIdent_77C29 = 1;
																						break;
																					end
																					if (0 ~= FlatIdent_44265) then
																					else
																						local FlatIdent_79729 = 0;
																						local FlatIdent_77478;
																						while true do
																							if (0 ~= FlatIdent_79729) then
																							else
																								FlatIdent_77478 = 0;
																								while true do
																									if (FlatIdent_77478 ~= 0) then
																									else
																										local FlatIdent_974E = 0;
																										while true do
																											if (FlatIdent_974E == 0) then
																												C = {};
																												D = Instance.new(LUAOBFUSACTOR_DECRYPT_STR_0("\217\61\30\25\193\57\4\8\225", "\141\88\102\109"), Parent);
																												FlatIdent_974E = 1;
																											end
																											if (FlatIdent_974E ~= 1) then
																											else
																												FlatIdent_77478 = 1;
																												break;
																											end
																										end
																									end
																									if (1 ~= FlatIdent_77478) then
																									else
																										FlatIdent_44265 = 1;
																										break;
																									end
																								end
																								break;
																							end
																						end
																					end
																				end
																				break;
																			end
																		end
																		break;
																	end
																end
															end
															break;
														end
													end
													break;
												end
											end
										end
										break;
									end
									if (FlatIdent_581C8 ~= 0) then
									else
										local FlatIdent_47EEF = 0;
										while true do
											if (FlatIdent_47EEF == 1) then
												FlatIdent_581C8 = 1;
												break;
											end
											if (FlatIdent_47EEF ~= 0) then
											else
												FlatIdent_77C29 = 0;
												C = nil;
												FlatIdent_47EEF = 1;
											end
										end
									end
								end
								break;
							end
							if (FlatIdent_44265 ~= 1) then
							else
								C = nil;
								D = nil;
								FlatIdent_44265 = 2;
							end
						end
						break;
					end
					if (FlatIdent_51C44 == 1) then
						FlatIdent_77C29 = nil;
						C = nil;
						FlatIdent_51C44 = 2;
					end
					if (FlatIdent_51C44 ~= 0) then
					else
						FlatIdent_44265 = 0;
						FlatIdent_581C8 = nil;
						FlatIdent_51C44 = 1;
					end
					if (FlatIdent_51C44 ~= 2) then
					else
						D = nil;
						stroke = nil;
						FlatIdent_51C44 = 3;
					end
				end
			end
			FlatIdent_882F4 = 1;
		end
		if (FlatIdent_882F4 ~= 2) then
		else
			if (v ~= LUAOBFUSACTOR_DECRYPT_STR_0("\111\240\24\81", "\62\133\121\53\227\127\109\79")) then
			else
				local FlatIdent_2B986 = 0;
				local FlatIdent_1CFC3;
				local f;
				while true do
					if (1 == FlatIdent_2B986) then
						while true do
							if (FlatIdent_1CFC3 ~= 0) then
							else
								f = {Drawing.new(LUAOBFUSACTOR_DECRYPT_STR_0("\142\25\26\55", "\194\112\116\82\149\182\206")),Drawing.new(LUAOBFUSACTOR_DECRYPT_STR_0("\34\48\166\73", "\110\89\200\44\120\160\130")),Drawing.new(LUAOBFUSACTOR_DECRYPT_STR_0("\97\162\205\78", "\45\203\163\43\38\35\42\91")),Drawing.new(LUAOBFUSACTOR_DECRYPT_STR_0("\120\219\139\217", "\52\178\229\188\67\231\201"))};
								return setmetatable({[LUAOBFUSACTOR_DECRYPT_STR_0("\17\36\76\95\18\242", "\67\65\33\48\100\151\60")]=function(self)
									local FlatIdent_90113 = 0;
									local FlatIdent_5B2CE;
									while true do
										if (FlatIdent_90113 ~= 0) then
										else
											FlatIdent_5B2CE = 0;
											while true do
												if (FlatIdent_5B2CE ~= 1) then
												else
													for h = 1, 4 do
														f[h]:Remove();
													end
													break;
												end
												if (FlatIdent_5B2CE ~= 0) then
												else
													local FlatIdent_5C0FA = 0;
													local FlatIdent_6D884;
													while true do
														if (FlatIdent_5C0FA == 0) then
															FlatIdent_6D884 = 0;
															while true do
																if (0 ~= FlatIdent_6D884) then
																else
																	local FlatIdent_87C42 = 0;
																	while true do
																		if (FlatIdent_87C42 ~= 1) then
																		else
																			FlatIdent_6D884 = 1;
																			break;
																		end
																		if (0 ~= FlatIdent_87C42) then
																		else
																			setmetatable(g, {});
																			self.Remove = nil;
																			FlatIdent_87C42 = 1;
																		end
																	end
																end
																if (FlatIdent_6D884 ~= 1) then
																else
																	FlatIdent_5B2CE = 1;
																	break;
																end
															end
															break;
														end
													end
												end
											end
											break;
										end
									end
								end}, {[LUAOBFUSACTOR_DECRYPT_STR_0("\204\224\233\171\207\250\209\227\171\192", "\147\191\135\206\184")]=function(self, i, j)
									local FlatIdent_94BA0 = 0;
									local k;
									while true do
										if (0 ~= FlatIdent_94BA0) then
										else
											if b[i] then
												local FlatIdent_42B8B = 0;
												local FlatIdent_35C62;
												while true do
													if (FlatIdent_42B8B ~= 0) then
													else
														FlatIdent_35C62 = 0;
														while true do
															if (FlatIdent_35C62 ~= 0) then
															else
																local FlatIdent_2B4B0 = 0;
																while true do
																	if (FlatIdent_2B4B0 ~= 0) then
																	else
																		for h = 1, 4 do
																			f[h][i] = j;
																		end
																		return;
																	end
																end
															end
														end
														break;
													end
												end
											end
											k = c[i];
											FlatIdent_94BA0 = 1;
										end
										if (FlatIdent_94BA0 ~= 1) then
										else
											if k then
												local FlatIdent_1077D = 0;
												local FlatIdent_2388;
												while true do
													if (0 ~= FlatIdent_1077D) then
													else
														FlatIdent_2388 = 0;
														while true do
															local FlatIdent_89C1C = 0;
															local FlatIdent_499B1;
															local FlatIdent_33DE6;
															while true do
																if (FlatIdent_89C1C ~= 1) then
																else
																	while true do
																		if (FlatIdent_499B1 ~= 0) then
																		else
																			FlatIdent_33DE6 = 0;
																			while true do
																				if (0 == FlatIdent_33DE6) then
																					if (1 == FlatIdent_2388) then
																						local FlatIdent_851CE = 0;
																						local FlatIdent_3F15E;
																						while true do
																							if (FlatIdent_851CE ~= 0) then
																							else
																								FlatIdent_3F15E = 0;
																								while true do
																									if (FlatIdent_3F15E ~= 0) then
																									else
																										local FlatIdent_61F8E = 0;
																										while true do
																											if (FlatIdent_61F8E ~= 0) then
																											else
																												local FlatIdent_29A75 = 0;
																												while true do
																													if (FlatIdent_29A75 ~= 0) then
																													else
																														f[(obf_AND(k, 1) + obf_OR(k, 1)) - (a(k / 4) * 4)].To = j;
																														return;
																													end
																												end
																											end
																										end
																									end
																								end
																								break;
																							end
																						end
																					end
																					if (FlatIdent_2388 ~= 0) then
																					else
																						local FlatIdent_80652 = 0;
																						while true do
																							if (1 ~= FlatIdent_80652) then
																							else
																								FlatIdent_2388 = 1;
																								break;
																							end
																							if (FlatIdent_80652 == 0) then
																								k = c[tostring(i):sub(-1)];
																								f[k].From = j;
																								FlatIdent_80652 = 1;
																							end
																						end
																					end
																					break;
																				end
																			end
																			break;
																		end
																	end
																	break;
																end
																if (FlatIdent_89C1C ~= 0) then
																else
																	FlatIdent_499B1 = 0;
																	FlatIdent_33DE6 = nil;
																	FlatIdent_89C1C = 1;
																end
															end
														end
														break;
													end
												end
											end
											break;
										end
									end
								end});
							end
						end
						break;
					end
					if (FlatIdent_2B986 ~= 0) then
					else
						FlatIdent_1CFC3 = 0;
						f = nil;
						FlatIdent_2B986 = 1;
					end
				end
			end
			if (v == LUAOBFUSACTOR_DECRYPT_STR_0("\134\150\33\167\207\223\95\183", "\210\228\72\198\161\184\51")) then
				local FlatIdent_7517F = 0;
				local f;
				while true do
					if (0 ~= FlatIdent_7517F) then
					else
						local FlatIdent_56F59 = 0;
						while true do
							if (FlatIdent_56F59 ~= 0) then
							else
								local FlatIdent_974E = 0;
								while true do
									if (FlatIdent_974E == 0) then
										local FlatIdent_93FA5 = 0;
										while true do
											if (0 ~= FlatIdent_93FA5) then
											else
												f = {Drawing.new(LUAOBFUSACTOR_DECRYPT_STR_0("\226\63\71\246", "\174\86\41\147\112\19")),Drawing.new(LUAOBFUSACTOR_DECRYPT_STR_0("\135\82\14\136", "\203\59\96\237\107\69\111\113")),Drawing.new(LUAOBFUSACTOR_DECRYPT_STR_0("\251\45\24\169", "\183\68\118\204\129\81\144"))};
												return setmetatable({[LUAOBFUSACTOR_DECRYPT_STR_0("\176\11\160\127\242\14", "\226\110\205\16\132\107")]=function(self)
													local FlatIdent_1784A = 0;
													local FlatIdent_4D907;
													local FlatIdent_3121;
													local FlatIdent_69253;
													while true do
														if (FlatIdent_1784A == 0) then
															FlatIdent_4D907 = 0;
															FlatIdent_3121 = nil;
															FlatIdent_1784A = 1;
														end
														if (FlatIdent_1784A ~= 1) then
														else
															FlatIdent_69253 = nil;
															while true do
																if (FlatIdent_4D907 ~= 1) then
																else
																	while true do
																		if (FlatIdent_3121 == 0) then
																			FlatIdent_69253 = 0;
																			while true do
																				if (0 == FlatIdent_69253) then
																					local FlatIdent_1E5DB = 0;
																					while true do
																						if (FlatIdent_1E5DB == 0) then
																							local FlatIdent_3C1AA = 0;
																							while true do
																								if (FlatIdent_3C1AA ~= 1) then
																								else
																									FlatIdent_1E5DB = 1;
																									break;
																								end
																								if (FlatIdent_3C1AA ~= 0) then
																								else
																									setmetatable(g, {});
																									self.Remove = nil;
																									FlatIdent_3C1AA = 1;
																								end
																							end
																						end
																						if (FlatIdent_1E5DB == 1) then
																							FlatIdent_69253 = 1;
																							break;
																						end
																					end
																				end
																				if (1 ~= FlatIdent_69253) then
																				else
																					for h = 1, 3 do
																						f[h]:Remove();
																					end
																					break;
																				end
																			end
																			break;
																		end
																	end
																	break;
																end
																if (FlatIdent_4D907 ~= 0) then
																else
																	FlatIdent_3121 = 0;
																	FlatIdent_69253 = nil;
																	FlatIdent_4D907 = 1;
																end
															end
															break;
														end
													end
												end}, {[LUAOBFUSACTOR_DECRYPT_STR_0("\126\212\205\229\206\72\229\199\229\193", "\33\139\163\128\185")]=function(self, i, j)
													local FlatIdent_82A94 = 0;
													local k;
													while true do
														if (FlatIdent_82A94 ~= 1) then
														else
															if k then
																local FlatIdent_602BB = 0;
																local FlatIdent_6066D;
																while true do
																	if (FlatIdent_602BB ~= 0) then
																	else
																		FlatIdent_6066D = 0;
																		while true do
																			local FlatIdent_15354 = 0;
																			while true do
																				if (FlatIdent_15354 ~= 0) then
																				else
																					if (FlatIdent_6066D ~= 0) then
																					else
																						local FlatIdent_6038 = 0;
																						local FlatIdent_1B5ED;
																						while true do
																							if (FlatIdent_6038 == 0) then
																								FlatIdent_1B5ED = 0;
																								while true do
																									if (FlatIdent_1B5ED ~= 0) then
																									else
																										k = c[tostring(i):sub(-1)];
																										f[k].From = j;
																										FlatIdent_1B5ED = 1;
																									end
																									if (FlatIdent_1B5ED ~= 1) then
																									else
																										FlatIdent_6066D = 1;
																										break;
																									end
																								end
																								break;
																							end
																						end
																					end
																					if (FlatIdent_6066D ~= 1) then
																					else
																						local FlatIdent_2F3FA = 0;
																						while true do
																							if (FlatIdent_2F3FA ~= 0) then
																							else
																								f[(obf_AND(k, 1) + obf_OR(k, 1)) - (a(k / 3) * 3)].To = j;
																								return;
																							end
																						end
																					end
																					break;
																				end
																			end
																		end
																		break;
																	end
																end
															end
															break;
														end
														if (0 ~= FlatIdent_82A94) then
														else
															if b[i] then
																local FlatIdent_2B986 = 0;
																local FlatIdent_40096;
																local FlatIdent_6A091;
																while true do
																	if (1 == FlatIdent_2B986) then
																		while true do
																			if (FlatIdent_40096 ~= 0) then
																			else
																				FlatIdent_6A091 = 0;
																				while true do
																					if (FlatIdent_6A091 ~= 0) then
																					else
																						local FlatIdent_7DB9E = 0;
																						local FlatIdent_622B0;
																						while true do
																							if (FlatIdent_7DB9E == 0) then
																								FlatIdent_622B0 = 0;
																								while true do
																									if (FlatIdent_622B0 == 0) then
																										local FlatIdent_458D1 = 0;
																										local FlatIdent_3416F;
																										while true do
																											if (FlatIdent_458D1 ~= 0) then
																											else
																												FlatIdent_3416F = 0;
																												while true do
																													if (FlatIdent_3416F ~= 0) then
																													else
																														local FlatIdent_21387 = 0;
																														while true do
																															if (FlatIdent_21387 ~= 0) then
																															else
																																for h = 1, 3 do
																																	f[h][i] = j;
																																end
																																return;
																															end
																														end
																													end
																												end
																												break;
																											end
																										end
																									end
																								end
																								break;
																							end
																						end
																					end
																				end
																				break;
																			end
																		end
																		break;
																	end
																	if (FlatIdent_2B986 == 0) then
																		local FlatIdent_2861D = 0;
																		while true do
																			if (FlatIdent_2861D == 0) then
																				FlatIdent_40096 = 0;
																				FlatIdent_6A091 = nil;
																				FlatIdent_2861D = 1;
																			end
																			if (FlatIdent_2861D ~= 1) then
																			else
																				FlatIdent_2B986 = 1;
																				break;
																			end
																		end
																	end
																end
															end
															k = c[i];
															FlatIdent_82A94 = 1;
														end
													end
												end});
											end
										end
									end
								end
							end
						end
					end
				end
			end
			break;
		end
		if (FlatIdent_882F4 ~= 1) then
		else
			local FlatIdent_1FA0 = 0;
			while true do
				if (0 == FlatIdent_1FA0) then
					if (v ~= LUAOBFUSACTOR_DECRYPT_STR_0("\226\186\65\201\124\31", "\161\211\51\170\16\122\93\53")) then
					else
						local A = {};
						local B = Instance.new(LUAOBFUSACTOR_DECRYPT_STR_0("\14\233\175\191\45", "\72\155\206\210"), Parent);
						B.BorderSizePixel = 0;
						B.AnchorPoint = Vector2.new(0.5, 0.5);
						Instance.new(LUAOBFUSACTOR_DECRYPT_STR_0("\6\111\89\91\28\61\67\104", "\83\38\26\52\110"), B).CornerRadius = UDim.new(1, 0);
						local stroke = Instance.new(LUAOBFUSACTOR_DECRYPT_STR_0("\115\113\36\51\84\87\28\34", "\38\56\119\71"), B);
						stroke.Thickness = 0.5;
						stroke.Color = Color3.new(0, 0, 0);
						stroke.Enabled = false;
						return setmetatable({}, {[LUAOBFUSACTOR_DECRYPT_STR_0("\105\204\230\86\210\32\78", "\54\147\143\56\182\69")]=function(self, x)
							local FlatIdent_8B272 = 0;
							while true do
								if (0 ~= FlatIdent_8B272) then
								else
									if ((x == LUAOBFUSACTOR_DECRYPT_STR_0("\237\211\140\240\95\218", "\191\182\225\159\41")) or (x == LUAOBFUSACTOR_DECRYPT_STR_0("\230\46\1\60\71\132\158", "\162\75\114\72\53\235\231"))) then
										return function()
											B:Destroy();
										end;
									end
									return A[x];
								end
							end
						end,[LUAOBFUSACTOR_DECRYPT_STR_0("\61\179\50\65\245\90\12\136\57\92", "\98\236\92\36\130\51")]=function(self, x, y)
							local FlatIdent_90271 = 0;
							local FlatIdent_145D2;
							local FlatIdent_53124;
							local FlatIdent_295EB;
							while true do
								if (FlatIdent_90271 == 1) then
									FlatIdent_295EB = nil;
									while true do
										if (FlatIdent_145D2 ~= 0) then
										else
											local FlatIdent_5E6B6 = 0;
											while true do
												if (FlatIdent_5E6B6 ~= 0) then
												else
													FlatIdent_53124 = 0;
													FlatIdent_295EB = nil;
													FlatIdent_5E6B6 = 1;
												end
												if (1 == FlatIdent_5E6B6) then
													FlatIdent_145D2 = 1;
													break;
												end
											end
										end
										if (FlatIdent_145D2 == 1) then
											while true do
												if (FlatIdent_53124 == 0) then
													FlatIdent_295EB = 0;
													while true do
														if (FlatIdent_295EB ~= 2) then
														else
															local FlatIdent_65194 = 0;
															local FlatIdent_69C4C;
															while true do
																if (FlatIdent_65194 ~= 0) then
																else
																	FlatIdent_69C4C = 0;
																	while true do
																		if (FlatIdent_69C4C ~= 0) then
																		else
																			local FlatIdent_167D2 = 0;
																			local FlatIdent_1BA2F;
																			while true do
																				if (FlatIdent_167D2 ~= 0) then
																				else
																					FlatIdent_1BA2F = 0;
																					while true do
																						if (FlatIdent_1BA2F ~= 0) then
																						else
																							if (x ~= LUAOBFUSACTOR_DECRYPT_STR_0("\19\171\21\3\168", "\80\196\121\108\218\37\200\213")) then
																							else
																								local FlatIdent_8E5B4 = 0;
																								local FlatIdent_94AF7;
																								while true do
																									if (FlatIdent_8E5B4 ~= 0) then
																									else
																										FlatIdent_94AF7 = 0;
																										while true do
																											if (FlatIdent_94AF7 ~= 0) then
																											else
																												B.BackgroundColor3 = y;
																												stroke.Color = y;
																												break;
																											end
																										end
																										break;
																									end
																								end
																							end
																							if (x ~= LUAOBFUSACTOR_DECRYPT_STR_0("\186\15\96\11\107\66\1\132", "\234\96\19\98\31\43\110")) then
																							else
																								B.Position = UDim2.new(0, y.X, 0, y.Y);
																							end
																							FlatIdent_1BA2F = 1;
																						end
																						if (1 ~= FlatIdent_1BA2F) then
																						else
																							FlatIdent_69C4C = 1;
																							break;
																						end
																					end
																					break;
																				end
																			end
																		end
																		if (1 ~= FlatIdent_69C4C) then
																		else
																			FlatIdent_295EB = 3;
																			break;
																		end
																	end
																	break;
																end
															end
														end
														if (FlatIdent_295EB == 3) then
															if (x ~= LUAOBFUSACTOR_DECRYPT_STR_0("\185\7\27\91\210\191", "\235\102\127\50\167\204\18")) then
															else
																B.Size = UDim2.new(0, y * 2, 0, y * 2);
															end
															break;
														end
														if (FlatIdent_295EB == 0) then
															local FlatIdent_229D1 = 0;
															while true do
																if (FlatIdent_229D1 ~= 0) then
																else
																	A[x] = y;
																	if (x ~= LUAOBFUSACTOR_DECRYPT_STR_0("\24\89\178\252\33\72\43", "\78\48\193\149\67\36")) then
																	else
																		B.Visible = y;
																	end
																	FlatIdent_229D1 = 1;
																end
																if (FlatIdent_229D1 ~= 1) then
																else
																	FlatIdent_295EB = 1;
																	break;
																end
															end
														end
														if (FlatIdent_295EB ~= 1) then
														else
															local FlatIdent_699E4 = 0;
															while true do
																if (FlatIdent_699E4 ~= 0) then
																else
																	if (x ~= LUAOBFUSACTOR_DECRYPT_STR_0("\103\57\18\140\29\69", "\33\80\126\224\120")) then
																	else
																		local FlatIdent_259C6 = 0;
																		local FlatIdent_1D701;
																		local FlatIdent_7873D;
																		local FlatIdent_189F0;
																		while true do
																			if (FlatIdent_259C6 == 0) then
																				FlatIdent_1D701 = 0;
																				FlatIdent_7873D = nil;
																				FlatIdent_259C6 = 1;
																			end
																			if (FlatIdent_259C6 == 1) then
																				FlatIdent_189F0 = nil;
																				while true do
																					if (FlatIdent_1D701 ~= 0) then
																					else
																						local FlatIdent_7C89 = 0;
																						while true do
																							if (FlatIdent_7C89 ~= 0) then
																							else
																								FlatIdent_7873D = 0;
																								FlatIdent_189F0 = nil;
																								FlatIdent_7C89 = 1;
																							end
																							if (1 == FlatIdent_7C89) then
																								FlatIdent_1D701 = 1;
																								break;
																							end
																						end
																					end
																					if (1 == FlatIdent_1D701) then
																						while true do
																							if (FlatIdent_7873D ~= 0) then
																							else
																								FlatIdent_189F0 = 0;
																								while true do
																									if (FlatIdent_189F0 ~= 0) then
																									else
																										B.BackgroundTransparency = ((y == true) and 0) or 1;
																										stroke.Enabled = not y;
																										break;
																									end
																								end
																								break;
																							end
																						end
																						break;
																					end
																				end
																				break;
																			end
																		end
																	end
																	if (x ~= LUAOBFUSACTOR_DECRYPT_STR_0("\104\254\169\13\215\76\237\186\6\202\95\245", "\60\140\200\99\164")) then
																	else
																		B.BackgroundTransparency = 1 - y;
																	end
																	FlatIdent_699E4 = 1;
																end
																if (FlatIdent_699E4 ~= 1) then
																else
																	FlatIdent_295EB = 2;
																	break;
																end
															end
														end
													end
													break;
												end
											end
											break;
										end
									end
									break;
								end
								if (FlatIdent_90271 == 0) then
									FlatIdent_145D2 = 0;
									FlatIdent_53124 = nil;
									FlatIdent_90271 = 1;
								end
							end
						end});
					end
					if (v ~= LUAOBFUSACTOR_DECRYPT_STR_0("\145\150\225\5\52\167", "\194\231\148\100\70")) then
					else
						local FlatIdent_60344 = 0;
						local FlatIdent_7699F;
						local FlatIdent_43337;
						local FlatIdent_2A862;
						local E;
						local F;
						local stroke;
						while true do
							if (FlatIdent_60344 == 3) then
								while true do
									if (1 ~= FlatIdent_7699F) then
									else
										E = nil;
										F = nil;
										FlatIdent_7699F = 2;
									end
									if (FlatIdent_7699F ~= 2) then
									else
										stroke = nil;
										while true do
											if (FlatIdent_43337 ~= 0) then
											else
												FlatIdent_2A862 = 0;
												E = nil;
												FlatIdent_43337 = 1;
											end
											if (FlatIdent_43337 ~= 2) then
											else
												while true do
													local FlatIdent_D6BD = 0;
													local FlatIdent_71EE8;
													while true do
														if (FlatIdent_D6BD ~= 0) then
														else
															FlatIdent_71EE8 = 0;
															while true do
																if (1 ~= FlatIdent_71EE8) then
																else
																	if (FlatIdent_2A862 ~= 2) then
																	else
																		local FlatIdent_508D4 = 0;
																		while true do
																			if (1 ~= FlatIdent_508D4) then
																			else
																				FlatIdent_2A862 = 3;
																				break;
																			end
																			if (FlatIdent_508D4 == 0) then
																				local FlatIdent_1DD0B = 0;
																				while true do
																					if (FlatIdent_1DD0B == 1) then
																						FlatIdent_508D4 = 1;
																						break;
																					end
																					if (FlatIdent_1DD0B ~= 0) then
																					else
																						stroke.Thickness = 0.5;
																						stroke.Color = Color3.new(0, 0, 0);
																						FlatIdent_1DD0B = 1;
																					end
																				end
																			end
																		end
																	end
																	if (FlatIdent_2A862 ~= 1) then
																	else
																		local FlatIdent_37395 = 0;
																		local FlatIdent_1691A;
																		while true do
																			if (FlatIdent_37395 == 0) then
																				FlatIdent_1691A = 0;
																				while true do
																					if (FlatIdent_1691A == 1) then
																						FlatIdent_2A862 = 2;
																						break;
																					end
																					if (FlatIdent_1691A ~= 0) then
																					else
																						local FlatIdent_6CF78 = 0;
																						while true do
																							if (FlatIdent_6CF78 ~= 0) then
																							else
																								F.BorderSizePixel = 0;
																								stroke = Instance.new(LUAOBFUSACTOR_DECRYPT_STR_0("\253\111\127\213\177\249\195\67", "\168\38\44\161\195\150"), F);
																								FlatIdent_6CF78 = 1;
																							end
																							if (FlatIdent_6CF78 ~= 1) then
																							else
																								FlatIdent_1691A = 1;
																								break;
																							end
																						end
																					end
																				end
																				break;
																			end
																		end
																	end
																	break;
																end
																if (FlatIdent_71EE8 == 0) then
																	local FlatIdent_38BFA = 0;
																	while true do
																		if (FlatIdent_38BFA == 1) then
																			FlatIdent_71EE8 = 1;
																			break;
																		end
																		if (FlatIdent_38BFA ~= 0) then
																		else
																			local FlatIdent_97F0B = 0;
																			while true do
																				if (FlatIdent_97F0B ~= 0) then
																				else
																					if (FlatIdent_2A862 ~= 3) then
																					else
																						local FlatIdent_1F620 = 0;
																						while true do
																							if (FlatIdent_1F620 ~= 0) then
																							else
																								stroke.Enabled = false;
																								return setmetatable({}, {[LUAOBFUSACTOR_DECRYPT_STR_0("\41\191\245\140\114\53\240", "\118\224\156\226\22\80\136\214")]=function(self, x)
																									local FlatIdent_8BE54 = 0;
																									local FlatIdent_AC2F;
																									while true do
																										if (FlatIdent_8BE54 ~= 0) then
																										else
																											FlatIdent_AC2F = 0;
																											while true do
																												if (FlatIdent_AC2F ~= 0) then
																												else
																													local FlatIdent_33D5A = 0;
																													while true do
																														if (FlatIdent_33D5A ~= 0) then
																														else
																															if ((x == LUAOBFUSACTOR_DECRYPT_STR_0("\178\71\227\86\150\71", "\224\34\142\57")) or (x == LUAOBFUSACTOR_DECRYPT_STR_0("\42\219\180\209\207\124\232", "\110\190\199\165\189\19\145\61"))) then
																																return function()
																																	F:Destroy();
																																end;
																															end
																															return E[x];
																														end
																													end
																												end
																											end
																											break;
																										end
																									end
																								end,[LUAOBFUSACTOR_DECRYPT_STR_0("\248\229\229\114\255\130\201\222\238\111", "\167\186\139\23\136\235")]=function(self, x, y)
																									local FlatIdent_4E551 = 0;
																									while true do
																										if (FlatIdent_4E551 ~= 1) then
																										else
																											if (x ~= LUAOBFUSACTOR_DECRYPT_STR_0("\46\21\185\135\31", "\109\122\213\232")) then
																											else
																												local FlatIdent_1FAE6 = 0;
																												local FlatIdent_6F99F;
																												local FlatIdent_68E92;
																												while true do
																													if (FlatIdent_1FAE6 ~= 1) then
																													else
																														while true do
																															if (FlatIdent_6F99F ~= 0) then
																															else
																																FlatIdent_68E92 = 0;
																																while true do
																																	if (FlatIdent_68E92 ~= 0) then
																																	else
																																		F.BackgroundColor3 = y;
																																		stroke.Color = y;
																																		break;
																																	end
																																end
																																break;
																															end
																														end
																														break;
																													end
																													if (FlatIdent_1FAE6 ~= 0) then
																													else
																														FlatIdent_6F99F = 0;
																														FlatIdent_68E92 = nil;
																														FlatIdent_1FAE6 = 1;
																													end
																												end
																											end
																											if (x ~= LUAOBFUSACTOR_DECRYPT_STR_0("\4\252\246\172\35\254\246\176\53\224\244\187", "\80\142\151\194")) then
																											else
																												F.BackgroundTransparency = math.clamp(1 - y, 0, 1);
																											end
																											FlatIdent_4E551 = 2;
																										end
																										if (FlatIdent_4E551 == 0) then
																											local FlatIdent_943B = 0;
																											local FlatIdent_15034;
																											while true do
																												if (FlatIdent_943B == 0) then
																													FlatIdent_15034 = 0;
																													while true do
																														if (FlatIdent_15034 ~= 1) then
																														else
																															FlatIdent_4E551 = 1;
																															break;
																														end
																														if (FlatIdent_15034 ~= 0) then
																														else
																															E[x] = y;
																															if (x ~= LUAOBFUSACTOR_DECRYPT_STR_0("\122\10\213\126\78\15\195", "\44\99\166\23")) then
																															else
																																local FlatIdent_89562 = 0;
																																while true do
																																	if (FlatIdent_89562 == 0) then
																																		E.Visible = true;
																																		F.Visible = y;
																																		break;
																																	end
																																end
																															end
																															FlatIdent_15034 = 1;
																														end
																													end
																													break;
																												end
																											end
																										end
																										if (2 ~= FlatIdent_4E551) then
																										else
																											if (x ~= LUAOBFUSACTOR_DECRYPT_STR_0("\148\115\228\32\34\58\171\114", "\196\28\151\73\86\83")) then
																											else
																												F.Position = UDim2.new(0, y.X, 0, y.Y);
																											end
																											if (x ~= LUAOBFUSACTOR_DECRYPT_STR_0("\80\250\15\37\21\134", "\22\147\99\73\112\226\56\120")) then
																											else
																												local FlatIdent_6C033 = 0;
																												while true do
																													if (0 ~= FlatIdent_6C033) then
																													else
																														F.BackgroundTransparency = ((y == true) and 0) or 1;
																														stroke.Enabled = not y;
																														break;
																													end
																												end
																											end
																											FlatIdent_4E551 = 3;
																										end
																										if (FlatIdent_4E551 ~= 3) then
																										else
																											if (x ~= LUAOBFUSACTOR_DECRYPT_STR_0("\190\177\111\231", "\237\216\21\130\149")) then
																											else
																												F.Size = UDim2.new(0, y.X, 0, y.Y);
																											end
																											break;
																										end
																									end
																								end});
																							end
																						end
																					end
																					if (FlatIdent_2A862 ~= 0) then
																					else
																						local FlatIdent_5E642 = 0;
																						local FlatIdent_61084;
																						local FlatIdent_31077;
																						while true do
																							if (FlatIdent_5E642 == 1) then
																								while true do
																									if (FlatIdent_61084 ~= 0) then
																									else
																										FlatIdent_31077 = 0;
																										while true do
																											if (1 ~= FlatIdent_31077) then
																											else
																												FlatIdent_2A862 = 1;
																												break;
																											end
																											if (FlatIdent_31077 ~= 0) then
																											else
																												local FlatIdent_2D05E = 0;
																												local FlatIdent_6B9E2;
																												while true do
																													if (FlatIdent_2D05E ~= 0) then
																													else
																														FlatIdent_6B9E2 = 0;
																														while true do
																															if (FlatIdent_6B9E2 == 0) then
																																E = {};
																																F = Instance.new(LUAOBFUSACTOR_DECRYPT_STR_0("\120\144\79\82\90", "\62\226\46\63\63\208\169"), Parent);
																																FlatIdent_6B9E2 = 1;
																															end
																															if (FlatIdent_6B9E2 == 1) then
																																FlatIdent_31077 = 1;
																																break;
																															end
																														end
																														break;
																													end
																												end
																											end
																										end
																										break;
																									end
																								end
																								break;
																							end
																							if (FlatIdent_5E642 == 0) then
																								FlatIdent_61084 = 0;
																								FlatIdent_31077 = nil;
																								FlatIdent_5E642 = 1;
																							end
																						end
																					end
																					FlatIdent_97F0B = 1;
																				end
																				if (FlatIdent_97F0B == 1) then
																					FlatIdent_38BFA = 1;
																					break;
																				end
																			end
																		end
																	end
																end
															end
															break;
														end
													end
												end
												break;
											end
											if (FlatIdent_43337 ~= 1) then
											else
												local FlatIdent_5062 = 0;
												while true do
													if (FlatIdent_5062 == 1) then
														FlatIdent_43337 = 2;
														break;
													end
													if (0 == FlatIdent_5062) then
														F = nil;
														stroke = nil;
														FlatIdent_5062 = 1;
													end
												end
											end
										end
										break;
									end
									if (FlatIdent_7699F ~= 0) then
									else
										FlatIdent_43337 = 0;
										FlatIdent_2A862 = nil;
										FlatIdent_7699F = 1;
									end
								end
								break;
							end
							if (FlatIdent_60344 ~= 2) then
							else
								F = nil;
								stroke = nil;
								FlatIdent_60344 = 3;
							end
							if (FlatIdent_60344 ~= 0) then
							else
								FlatIdent_7699F = 0;
								FlatIdent_43337 = nil;
								FlatIdent_60344 = 1;
							end
							if (FlatIdent_60344 ~= 1) then
							else
								FlatIdent_2A862 = nil;
								E = nil;
								FlatIdent_60344 = 2;
							end
						end
					end
					FlatIdent_1FA0 = 1;
				end
				if (FlatIdent_1FA0 ~= 1) then
				else
					FlatIdent_882F4 = 2;
					break;
				end
			end
		end
	end
end);
