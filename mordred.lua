--[[
    Skrip Mordred oleh noemar (Versi Final dengan Venyx UI)
    Library diganti karena Rayfield tidak bisa diakses (HTTP 404).
]]

-- Memuat Library UI Venyx dari sumber resminya
local Venyx = loadstring(game:HttpGet("https://raw.githubusercontent.com/TheVenyx/Venyx/main/Venyx.lua"))()

-- Membuat Window (Jendela UI Utama)
local Window = Venyx.new({
    Title = "Mordred by noemar",
    -- Tema Warna (Merah sebagai aksen, sisanya gelap kebiruan)
    Accent = Color3.fromRGB(255, 40, 40),
    Header = Color3.fromRGB(35, 35, 45),
    Background = Color3.fromRGB(30, 30, 40),
    Primary = Color3.fromRGB(45, 45, 55),
    Secondary = Color3.fromRGB(25, 25, 35),
})

-- === Membuat Bagian Tab ===
local MainTab = Window:addPage({
    Title = "Utama"
})

-- Menambahkan Label dengan nama "noemar"
MainTab:addLabel({
    Text = "Script by noemar",
    Size = 20,
    Color = Color3.fromRGB(0, 0, 0) -- Warna Hitam
})

-- Menambahkan tombol
MainTab:addButton({
    Text = "Contoh Tombol",
    Callback = function()
        -- Fungsi yang akan dijalankan saat tombol diklik
        Window:notify({
            Title = "Mordred",
            Text = "Tombol ini berfungsi!",
        })
    end
})

-- Menambahkan toggle (saklar on/off)
MainTab:addToggle({
    Text = "Contoh Toggle",
    Callback = function(Value)
        if Value then
            print("Toggle diaktifkan!")
        else
            print("Toggle dinonaktifkan!")
        end
    end
})

-- Notifikasi saat skrip selesai dimuat
Window:notify({
    Title = "Selamat Datang!",
    Text = "Skrip Mordred berhasil dimuat dengan UI Venyx.",
    Duration = 8
})
