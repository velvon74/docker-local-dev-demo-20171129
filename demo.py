import os
from BaseHTTPServer import BaseHTTPRequestHandler, HTTPServer
import MySQLdb

# get configuration
MYSQL_HOST = os.environ.get('DEMO_MYSQL_HOST')
MYSQL_PORT = int(os.environ.get('DEMO_MYSQL_PORT'))
MYSQL_DB = os.environ.get('DEMO_MYSQL_DB')
MYSQL_USER = os.environ.get('DEMO_MYSQL_USER')
MYSQL_PASS = os.environ.get('DEMO_MYSQL_PASS')

class S(BaseHTTPRequestHandler):
    def _set_headers(self):
        self.send_response(200)
        self.send_header('Content-type', 'text/txt')
        self.end_headers()

    def do_GET(self):
        self._set_headers()
        # connect to the DB
        connection = MySQLdb.connect(
            host = MYSQL_HOST,
            port = MYSQL_PORT,
            user = MYSQL_USER,
            passwd = MYSQL_PASS)

        # get the cursor
        cursor = connection.cursor()

        # select DB
        cursor.execute("USE {DB}".format(
            DB = MYSQL_DB
        ))

        cursor.execute("SHOW TABLES")
        # print tables
        self.wfile.write('--demo app--\n\n')
        self.wfile.write('Tables in "{DB}":\n'.format(
            DB = MYSQL_DB
        ))
        no_tables = True
        for (table_name,) in cursor:
            no_tables = False
            self.wfile.write(''.join(['  ',table_name, '\n']))
        if no_tables:
            self.wfile.write('no tables\n')

    def do_HEAD(self):
        self._set_headers()


def run(server_class=HTTPServer, handler_class=S, port=8000):
    server_address = ('', port)
    httpd = server_class(server_address, handler_class)
    print 'Starting httpd...'
    httpd.serve_forever()

if __name__ == "__main__":
    run()
