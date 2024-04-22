### Terraform

the terraform code i wrote used the default vpc and security group it comes with so it lessens my hassle to connect an IGW andits subsequent route table and security group too. however i can alter them tooa ccordin to my applications need.

### Error Encountered

Permission dneied while trying to connect to the docker socket. i also had previously encountered this issue and was able to solve it by adding the current user to the docker group.
```bash
sudo usermod -aG docker $USER
```

However while trying the same with the cloud-inti it was not happening. since cloud-init suns as root by default it could be taking root as the value when i mention `$USER` while i append the docker group.

### Solved

seems the cloud-init did passed the root user to get append with the docker group. so user ubuntu was not getting acces to the docker socket unless usod was used.



The site with and without the `nip.io` dns :

![alt text](Screencastfrom04-23-2024035443AM-ezgif.com-video-to-gif-converter.gif)