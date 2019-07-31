import app
import unittest


class FlaskTestCase(unittest.TestCase):

    def setUp(self):
        app.app.config['TESTING'] = True
        self.app = app.app.test_client()

    def test_correct_http_response(self):
        resp = self.app.get('/')
        self.assertEqual(resp.status_code, 200)

    def tearDown(self):
        pass

if __name__ == '__main__':
    unittest.main()
