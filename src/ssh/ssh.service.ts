import { Injectable } from '@nestjs/common';
import { Client, ClientChannel } from 'ssh2';

@Injectable()
export class SshService {
  private sshClient: Client;

  async exec(systemData, command, pty) {
    this.sshClient = new Client();
    this.sshClient
      .on('ready', async () => {
        console.log(`Conectado ao servidor ${systemData.IP}`);
        this.sshClient.exec(
          command,
          { pty },
          (err: Error, stream: ClientChannel) => {
            if (err) throw err;
            stream
              .on('close', (code: any, signal: any) => {
                console.log(
                  `Conexão encerrada com o servidor ${systemData.IP}`,
                );
                console.log('Código: ' + code + ', Sinal: ' + signal);
                this.sshClient.end();
              })
              .on('data', (data: any) => {
                console.log('STDOUT: ' + data);

                if (
                  data.includes('password') ||
                  data.includes('Password') ||
                  data.includes('Password:') ||
                  data.includes('password:')
                ) {
                  stream.write(`${systemData.password}\n`);
                }

                if (data.includes('Overwrite?')) {
                  stream.write('y\n');
                }
              })
              .stderr.on('data', (data: any) => {
                console.log('STDERR: ' + data);
              });
          },
        );
      })
      .connect({
        host: systemData.IP,
        port: systemData.portSSH,
        username: systemData.username,
        password: systemData.password,
      });
  }
}
