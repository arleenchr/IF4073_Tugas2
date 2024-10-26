# Image Enhancement App
> Aplikasi yang memiliki fungsi-fungsi untuk melakukan perbaikan citra dengan ranah frekuensi. Dibuat untuk memenuhi Tugas 2 IF4073 Pemrosesan Citra Digital

## How to Run
- Clone repository ini ke local komputer dengan command `git clone https://github.com/arleenchr/IF4073_Tugas2.git`
- Buka aplikasi Matlab dan arahkan ke folder src
- Masukkan command `GUI` di Command Window untuk menjalankan GUI
- Pilih transformasi yang ingin dilakukan dan masukkan gambar yang ingin diproses
- Keterangan <br>
&emsp;1. <b>Konvolusi</b> <br>
Setelah memasukkan citra yang ingin diproses, masukkan convolution mask ke dalam kolom yang disediakan. <br>
&emsp;2. <b>Spatial Smoothing</b> <br>
Masukkan parameter filter size dan sigma.
&emsp;3. <b>Low and High Pass Filtering</b><br>
Pilih filter ideal, gaussian, ataupun butterworth. Kemudian masukkan parameter D0, juga n khusus untuk butterworth. <br>
&emsp;4. <b>Image Brightness</b><br>
Masukkan parameter brightness factor (tingkat seberapa cerah citra yang diinginkan). <br>
&emsp;5. <b>Noise Reduction (Salt and Pepper)</b><br>
Gunakan filter pada kolom filter (selain ideal, gaussian, dan butterworth). Untuk Contraharmonic mean dan alpha-trimmed mean, ada beberapa parameter yang harus diisi, yaitu Q untuk contraharmonic dan d untuk alpha-trimmed. <br>
&emsp;6. <b>Noise Reduction (Periodic)</b><br>
Gunakan parameter yang terdapat pada grup "Periodic Noise Reduction Option" (threshold dan notch size). <br>
&emsp;7. <b>Deconvolution</b><br>
Gunakan parameter yang terdapat pada grup "Deconvolution Option" (motion bluring, noise, len (panjang piksel terdistorsi untuk 'motion' dan besar matriks konvolusi untuk 'gaussian') dan theta (arah distorsi untuk 'motion' dan variansi untuk 'gaussian')). 
- Tekan tombol <b>OK</b> untuk memproses gambar


## Contributor
- 13521042 Kevin John Wesley Hutabarat
- 13521059 Arleen Chrysantha Gunardi
