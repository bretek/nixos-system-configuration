# secure boot
sudo sbctl create-keys
sudo sbctl enroll-keys --microsoft

# tpm disk unlock
sudo systemd-cryptenroll --tpm2-device=auto --tpm2-pcrs=7+14+15 --wipe-slot=tpm2 /dev/sda2

# secret keys
gpg --import <gpg-secret>
cp <ssh-secret> ~/.ssh/<ssh-secret>
