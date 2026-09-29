require "rails_helper"

RSpec.describe MailingListable do
  include ActiveJob::TestHelper

  let(:buttondown) { MockButtondown.new }
  before { allow(MailingListable).to receive(:buttondown).and_return(buttondown) }

  shared_context "without a Buttondown API key" do
    before do
      allow(MailingListable).to receive(:buttondown).and_call_original
      ENV.delete("BUTTONDOWN_API_KEY")
    end
  end

  describe "signing up" do
    it "subscribes users who ask to be" do
      create :user, email: "audrey@example.com", subscribe_to_mailing_list: true
      expect(buttondown.subscribers).to eq("audrey@example.com" => {})
    end

    it "leaves everyone else alone" do
      create :user
      expect(buttondown.subscribers).to be_empty
    end

    context "without a Buttondown API key" do
      include_context "without a Buttondown API key"

      it "never contacts Buttondown" do
        create :user, subscribe_to_mailing_list: true
        expect(a_request(:any, /buttondown/)).not_to have_been_made
      end
    end
  end

  describe "updating a user" do
    let!(:user) { create :user, :basic_profile, email: "audrey@example.com" }

    context "who is subscribed" do
      let(:buttondown) { MockButtondown.new("audrey@example.com" => {}) }

      it "moves their subscription to a changed email" do
        user.update!(email: "audrey@greatnorthern.example.com")
        expect(buttondown.subscribers).to eq("audrey@greatnorthern.example.com" => { "full_name" => "Audrey Horne" })
      end

      it "sends a changed name" do
        user.update!(formal_name: "Ms Horne")
        expect(buttondown.subscribers).to eq("audrey@example.com" => { "full_name" => "Audrey Horne", "formal_name" => "Ms Horne" })
      end

      it "ignores changes Buttondown doesn't store" do
        user.update!(phonetic: "AWD-ree")
        expect(buttondown.subscribers).to eq("audrey@example.com" => {})
      end
    end

    context "who isn't subscribed" do
      it "leaves them alone" do
        user.update!(full_name: "Audrey Briggs")
        expect(buttondown.subscribers).to be_empty
      end
    end

    context "without a Buttondown API key" do
      include_context "without a Buttondown API key"

      it "never contacts Buttondown" do
        user.update!(email: "audrey@greatnorthern.example.com")
        user.unsubscribe_from_mailing_list!
        expect(a_request(:any, /buttondown/)).not_to have_been_made
      end
    end
  end

  describe "when Buttondown fails" do
    let(:buttondown) { Buttondown.new("xxxyyy") }
    let!(:admin) { create :user, role: :admin, email: "gordon@example.com" }

    context "by rejecting the email" do
      before do
        stub_request(:get, %r{api.buttondown.email/v1/subscribers/}).to_return(status: 404)
        stub_request(:post, "https://api.buttondown.email/v1/subscribers").to_return(status: 400, body: "Invalid email")
      end

      it "still signs the user up" do
        expect { create :user, subscribe_to_mailing_list: true }.to change(User, :count).by(1)
      end

      it "emails the admins" do
        perform_enqueued_jobs { create :user, email: "audrey@example.com", subscribe_to_mailing_list: true }
        mail = ActionMailer::Base.deliveries.last
        expect(mail.to).to eq([ "gordon@example.com" ])
        expect(mail.body.to_s).to include("audrey@example.com").and include("Invalid email")
      end
    end

    context "by being unavailable" do
      before { stub_request(:any, /buttondown/).to_timeout }

      it "treats the user as unsubscribed" do
        expect(create(:user).subscribed_to_mailing_list?).to be_nil
      end

      it "still lets them leave" do
        expect { create(:user).destroy! }.to have_enqueued_mail(AdminMailer, :buttondown_failed)
      end
    end
  end

  describe "deleting a user" do
    let(:buttondown) { MockButtondown.new("audrey@example.com" => {}) }

    it "unsubscribes them" do
      create(:user, email: "audrey@example.com").destroy!
      expect(buttondown.subscribers).to be_empty
    end
  end
end
