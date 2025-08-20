--[[
    Mordred Script - Versi Debugging
    Dibuat untuk mendeteksi masalah pada game dengan anti-cheat.
]]

-- 1. Memberi tahu bahwa skrip dimulai
print("Mordred: Memulai eksekusi skrip...")

-- 2. Mencoba mengunduh library UI dengan aman
local success, rayfield_source = pcall(function()
    return game:HttpGet('https://raw.githubusercontent.com/shlexware/Rayfield/main/source', true)
end)

-- 3. Memeriksa apakah unduhan berhasil
if not success then
    -- Jika gagal, beri tahu alasannya
    warn("Mordred [ERROR]: Gagal mengunduh library Rayfield! Mungkin koneksi internet atau anti-cheat game memblokirnya.")
    warn("Detail Error:", rayfield_source) -- 'rayfield_source' akan berisi pesan error
    return -- Menghentikan skrip
end

print("Mordred: Library Rayfield berhasil diunduh.")

-- 4. Mencoba menjalankan library UI dengan aman
local success_load, library = pcall(loadstring(rayfield_source))

if not success_load then
    warn("Mordred [ERROR]: Gagal memuat library Rayfield! Anti-cheat game kemungkinan besar memblokir fungsi intinya.")
    warn("Detail Error:", library)
    return
end

print("Mordred: Library berhasil dimuat. Membuat UI...")

-- Semua kode UI-mu ada di dalam sini
local Rayfield = library()

-- Membuat Window (Jendela UI Utama)
local Window = Rayfield:CreateWindow({
    Name = "Mordred",
    LoadingTitle = "Mordred is Loading...",
    LoadingSubtitle = "by noemar",
    ConfigurationSaving = {
        Enabled = true,
        FolderName = "MordredConfig",
        FileName = "Mordred"
    },
    KeySystem = false,
    Logo = "rbxassetid://4483345998" 
})

-- Kustomisasi Tema Warna
Window:SetTheme({
    Background = Color3.fromRGB(30, 30, 40),
    Header = Color3.fromRGB(35, 35, 45),
    Primary = Color3.fromRGB(45, 45, 55),
    Secondary = Color3.fromRGB(25, 25, 35),
    Seperator = Color3.fromRGB(80, 80, 80),
    Rounding = 5,
    Accent = Color3.fromRGB(255, 40, 40),
    Text = Color3.fromRGB(255, 255, 255),
    AccentText = Color3.fromRGB(0, 0, 0)
})

local MainTab = Window:CreateTab("Utama", "rbxassetid://4483345998")

MainTab:CreateLabel({
    Text = "Script by noemar",
    TextSize = 18,
    TextColor = Color3.fromRGB(0, 0, 0),
    BgColor = Color3.fromRGB(200, 200, 200),
    Font = Enum.Font.SourceSansBold,
})

MainTab:CreateButton({
    Name = "Contoh Tombol",
    Callback = function()
        Rayfield:Notify({
            Title = "Mordred",
            Content = "Tombol ini berfungsi!",
            Duration = 5,
            Image = "rbxassetid://4483345998",
        })
    end,
})

print("Mordred: UI berhasil dibuat dan ditampilkan!")
