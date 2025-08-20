--[[
    Skrip Mordred oleh noemar
    Dibuat menggunakan Rayfield UI Library (Open Source)
]]

-- Memuat Library UI Rayfield dari sumber resminya
local Rayfield = loadstring(game:HttpGet('https://raw.githubusercontent.com/shlexware/Rayfield/main/source'))()

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
    Discord = {
        Enabled = false,
        Invite = "your_discord_invite", -- Ganti jika punya server discord
        RememberJoins = true
    },
    KeySystem = false, -- Tidak menggunakan sistem kunci
    -- Logo (Ganti 'rbxassetid://YOUR_LOGO_ID' dengan ID aset logo kamu)
    Logo = "rbxassetid://4483345998" 
})

-- Kustomisasi Tema Warna (Sesuai Permintaan)
Window:SetTheme({
    -- Warna Biru untuk UI
    Background = Color3.fromRGB(30, 30, 40),
    Header = Color3.fromRGB(35, 35, 45),
    Primary = Color3.fromRGB(45, 45, 55),
    Secondary = Color3.fromRGB(25, 25, 35),
    Seperator = Color3.fromRGB(80, 80, 80),
    Rounding = 5,
    -- Warna Merah untuk Aksen (Nama skrip, tombol, dll)
    Accent = Color3.fromRGB(255, 40, 40),
    -- Warna Hitam untuk Tulisan
    Text = Color3.fromRGB(255, 255, 255), -- Teks utama dibuat putih agar kontras
    AccentText = Color3.fromRGB(0, 0, 0) -- Teks pada elemen aksen (tombol) bisa dibuat hitam
})

-- === Membuat Bagian Tab ===
-- Di sinilah kamu akan meletakkan fitur-fitur skripmu

local MainTab = Window:CreateTab("Utama", "rbxassetid://4483345998") -- Tab utama

-- Menambahkan Label dengan nama "noemar"
MainTab:CreateLabel({
    Text = "Script by noemar",
    TextSize = 18,
    TextColor = Color3.fromRGB(0, 0, 0), -- Warna Hitam
    BgColor = Color3.fromRGB(200, 200, 200), -- Latar belakang abu-abu agar tulisan hitam terlihat
    Font = Enum.Font.SourceSansBold,
})

MainTab:CreateButton({
    Name = "Contoh Tombol",
    Callback = function()
        -- Fungsi yang akan dijalankan saat tombol diklik
        Rayfield:Notify({
            Title = "Mordred",
            Content = "Tombol ini berfungsi!",
            Duration = 5,
            Image = "rbxassetid://4483345998",
        })
    end,
})

-- Menambahkan toggle (saklar on/off)
MainTab:CreateToggle({
    Name = "Contoh Toggle",
    Callback = function(Value)
        -- 'Value' akan menjadi true jika ON, dan false jika OFF
        if Value then
            print("Toggle diaktifkan!")
        else
            print("Toggle dinonaktifkan!")
        end
    end,
    CurrentValue = false
})

-- Notifikasi saat skrip selesai dimuat
Rayfield:Notify({
    Title = "Selamat Datang!",
    Content = "Skrip Mordred oleh noemar berhasil dimuat.",
    Duration = 8,
    Image = "rbxassetid://4483345998",
    Actions = { -- Optional
        Ignore = {
            Name = "Okay!",
            Callback = function()
                print("Notifikasi ditutup.")
            end
        },
    },
})
